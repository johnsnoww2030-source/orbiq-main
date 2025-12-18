import 'package:dartz/dartz.dart';
import '../../domain/entities/exchange_rate.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import '../../domain/failures/exchange_rate_failure.dart';
import '../mappers/exchange_rate_mapper.dart';
import '../../../../core/database/daos/exchange_rate_dao.dart';
import '../../../../features/auth/domain/failures/failure.dart';

/// Implementation of ExchangeRateRepository
/// Delegates to DAO and handles error mapping
class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  final ExchangeRateDao dao;

  // Simple in-memory cache (5 minutes)
  final Map<String, _CachedRate> _cache = {};

  ExchangeRateRepositoryImpl(this.dao);

  @override
  Future<Either<Failure, ExchangeRate>> getCurrentRate(
    String currencyCode,
  ) async {
    try {
      // Check cache first (BR: 5-minute cache)
      if (_cache.containsKey(currencyCode)) {
        final cached = _cache[currencyCode]!;
        if (DateTime.now().difference(cached.timestamp).inMinutes < 5) {
          return Right(cached.rate);
        }
      }

      final data = await dao.getCurrentRate(currencyCode);
      if (data == null) {
        return const Left(ExchangeRateNotFoundFailure());
      }

      final entity = ExchangeRateMapper.toEntity(data);
      // Update cache
      _cache[currencyCode] = _CachedRate(entity, DateTime.now());

      return Right(entity);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExchangeRate>> getRateAtDate(
    String currencyCode,
    DateTime date,
  ) async {
    try {
      final data = await dao.getRateAtDate(currencyCode, date);
      if (data == null) {
        return const Left(
          ExchangeRateNotFoundFailure('No exchange rate found for this date'),
        );
      }

      return Right(ExchangeRateMapper.toEntity(data));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExchangeRate>> addRateEvent({
    required String currencyCode,
    required double rate,
    required String source,
    required String recordedBy,
    double confidence = 1.0,
    String? notes,
  }) async {
    try {
      final companion = ExchangeRateMapper.toCompanion(
        currencyCode: currencyCode,
        rate: rate,
        recordedAt: DateTime.now(),
        source: source,
        confidence: confidence,
        notes: notes,
        recordedBy: recordedBy,
      );

      final data = await dao.addRateEvent(companion);
      final entity = ExchangeRateMapper.toEntity(data);

      // Invalidate cache for this currency
      _cache.remove(currencyCode);

      return Right(entity);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExchangeRate>>> getRateHistory({
    required String currencyCode,
    DateTime? fromDate,
    DateTime? toDate,
    int? limit,
  }) async {
    try {
      final dataList = await dao.getRateHistory(
        currencyCode: currencyCode,
        fromDate: fromDate,
        toDate: toDate,
        limit: limit,
      );

      return Right(ExchangeRateMapper.toEntityList(dataList));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, ExchangeRate>>> getAllCurrentRates(
    List<String> currencyCodes,
  ) async {
    try {
      final dataMap = await dao.getAllCurrentRates(currencyCodes);
      final Map<String, ExchangeRate> entityMap = {};

      dataMap.forEach((code, data) {
        entityMap[code] = ExchangeRateMapper.toEntity(data);
      });

      return Right(entityMap);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, ExchangeRate>> watchCurrentRate(String currencyCode) {
    return dao.watchCurrentRate(currencyCode).map((data) {
      if (data == null) {
        return const Left(ExchangeRateNotFoundFailure());
      }
      return Right(ExchangeRateMapper.toEntity(data));
    });
  }
}

/// Internal class for caching rates
class _CachedRate {
  final ExchangeRate rate;
  final DateTime timestamp;

  _CachedRate(this.rate, this.timestamp);
}
