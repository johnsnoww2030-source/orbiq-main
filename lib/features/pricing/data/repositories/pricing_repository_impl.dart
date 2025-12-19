import 'package:dartz/dartz.dart';
import '../../domain/entities/pricing_settings.dart';
import '../../domain/repositories/pricing_repository.dart';
import '../../domain/value_objects/price_range.dart';

import '../mappers/pricing_settings_mapper.dart';
import '../../../auth/domain/failures/failure.dart';
import '../../../exchange_rate/domain/failures/exchange_rate_failure.dart';
import '../../../../core/database/daos/pricing_settings_dao.dart';

/// Implementation of PricingRepository
class PricingRepositoryImpl implements PricingRepository {
  final PricingSettingsDao dao;
  PricingSettings? _cachedSettings; // Simple cache

  PricingRepositoryImpl(this.dao);

  @override
  Future<Either<Failure, PricingSettings>> getSettings() async {
    try {
      // Return cached if available
      if (_cachedSettings != null) {
        return Right(_cachedSettings!);
      }

      final data = await dao.getSettings();
      if (data == null) {
        // Initialize with defaults if not found
        await dao.initializeDefaultSettings();
        final newData = await dao.getSettings();
        if (newData == null) {
          return const Left(DatabaseFailure('Failed to initialize settings'));
        }
        _cachedSettings = PricingSettingsMapper.toEntity(newData);
      } else {
        _cachedSettings = PricingSettingsMapper.toEntity(data);
      }

      return Right(_cachedSettings!);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PricingSettings>> saveSettings(
    PricingSettings settings,
  ) async {
    try {
      // Validate BR-2.5: Profit margin constraints
      if (settings.minProfitMargin < 0) {
        return const Left(
          ValidationFailure('Minimum profit margin cannot be negative'),
        );
      }

      if (settings.maxProfitMargin > 200) {
        return const Left(
          ValidationFailure('Maximum profit margin cannot exceed 200%'),
        );
      }

      if (!(settings.minProfitMargin < settings.defaultProfitMargin &&
          settings.defaultProfitMargin < settings.maxProfitMargin)) {
        return const Left(
          ValidationFailure('Margins must satisfy: min < default < max'),
        );
      }

      // Check minimum difference of 5%
      if ((settings.defaultProfitMargin - settings.minProfitMargin) < 5 ||
          (settings.maxProfitMargin - settings.defaultProfitMargin) < 5) {
        return const Left(
          ValidationFailure('Minimum 5% difference between margins required'),
        );
      }

      final companion = PricingSettingsMapper.toCompanion(
        settings,
        settings.updatedBy ?? 'system',
      );

      await dao.updateSettings(companion);

      // Invalidate cache and get fresh data
      _cachedSettings = null;
      return getSettings();
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Either<Failure, PriceRange> calculatePrices({
    required double costPrice,
    PricingSettings? settings,
  }) {
    try {
      final effectiveSettings = settings ?? _cachedSettings;
      if (effectiveSettings == null) {
        return const Left(ValidationFailure('Pricing settings not loaded'));
      }

      // BR-2.6: Calculate three prices
      final minPrice =
          costPrice * (1 + effectiveSettings.minProfitMargin / 100);
      final sellingPrice =
          costPrice * (1 + effectiveSettings.defaultProfitMargin / 100);
      final maxPrice =
          costPrice * (1 + effectiveSettings.maxProfitMargin / 100);

      // Round prices
      final roundedMin = roundPrice(
        minPrice,
        step: effectiveSettings.roundingStep,
      );
      final roundedSelling = roundPrice(
        sellingPrice,
        step: effectiveSettings.roundingStep,
      );
      final roundedMax = roundPrice(
        maxPrice,
        step: effectiveSettings.roundingStep,
      );

      return Right(
        PriceRange(
          minPrice: roundedMin,
          sellingPrice: roundedSelling,
          maxPrice: roundedMax,
          minProfitPercent: effectiveSettings.minProfitMargin,
          defaultProfitPercent: effectiveSettings.defaultProfitMargin,
          maxProfitPercent: effectiveSettings.maxProfitMargin,
          costPrice: costPrice,
        ),
      );
    } catch (e) {
      return Left(ValidationFailure(e.toString()));
    }
  }

  @override
  Either<Failure, double> convertToBaseCurrency({
    required double amount,
    required String fromCurrency,
    required double exchangeRate,
  }) {
    try {
      // BR-2.7: Currency conversion
      if (exchangeRate <= 0) {
        return const Left(ValidationFailure('Exchange rate must be positive'));
      }

      final converted = amount * exchangeRate;
      return Right(converted);
    } catch (e) {
      return Left(ValidationFailure(e.toString()));
    }
  }

  @override
  PriceValidationResult validateSellingPrice({
    required double sellingPrice,
    required double minPrice,
    required double maxPrice,
  }) {
    // BR-2.8: Price validation
    if (sellingPrice < minPrice) {
      return PriceValidationResult.belowMinimum; // RED warning + PIN
    } else if (sellingPrice > maxPrice) {
      return PriceValidationResult.aboveMaximum; // YELLOW warning
    }
    return PriceValidationResult.valid; // GREEN / OK
  }

  @override
  double roundPrice(double price, {int? step}) {
    final effectiveStep = step ?? _cachedSettings?.roundingStep ?? 10000;
    return (price / effectiveStep).round() * effectiveStep.toDouble();
  }
}
