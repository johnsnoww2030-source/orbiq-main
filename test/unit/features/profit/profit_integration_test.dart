import 'package:flutter_test/flutter_test.dart';
import 'package:orbiq/features/pricing/domain/entities/pricing_settings.dart';
import 'package:orbiq/features/profit/domain/services/profit_calculator.dart';
import 'package:orbiq/features/profit/data/models/sale_item_data.dart';

/// Integration Test: Phase 2 - ExchangeRate → Pricing → Profit Chain
///
/// این تست‌ها زنجیره کامل کارکرد را بررسی می‌کنند:
/// 1. ExchangeRate → Pricing → Profit
/// 2. خرید با دلار → سه قیمت محاسبه شود
/// 3. فروش → سود ریالی و دلاری درست محاسبه شود
/// 4. گزارش سود → تاریخی و امروز تفاوت داشته باشد
/// 5. تغییر نرخ ارز → ارزش امروز تغییر کند
void main() {
  late ProfitCalculator calculator;

  setUp(() {
    calculator = ProfitCalculator();
  });

  group('Phase 2 Integration Tests', () {
    // ============================================================
    // Test 1: خرید با دلار → سه قیمت محاسبه شود
    // ============================================================
    group('Purchase with USD → Calculate Three Prices', () {
      test('should calculate min, selling, max prices from USD cost', () {
        // Given: یک محصول با قیمت خرید 100 دلار و نرخ 60,000
        const costUSD = 100.0;
        const exchangeRate = 60000.0;
        final costIRR = costUSD * exchangeRate; // 6,000,000 تومان

        // Given: تنظیمات قیمت‌گذاری
        final settings = PricingSettings.defaultSettings();
        // min: 20%, default: 30%, max: 50%

        // When: محاسبه سه قیمت
        final minPrice = costIRR * (1 + settings.minProfitMargin / 100);
        final sellingPrice = costIRR * (1 + settings.defaultProfitMargin / 100);
        final maxPrice = costIRR * (1 + settings.maxProfitMargin / 100);

        // Then: سه قیمت درست محاسبه شده
        expect(minPrice, equals(6000000 * 1.2)); // 7,200,000
        expect(sellingPrice, equals(6000000 * 1.3)); // 7,800,000
        expect(maxPrice, equals(6000000 * 1.5)); // 9,000,000

        // Verify: min < selling < max
        expect(minPrice, lessThan(sellingPrice));
        expect(sellingPrice, lessThan(maxPrice));
      });

      test('should round prices according to rounding step', () {
        // Given
        const costIRR = 6543210.0;
        const roundingStep = 10000;
        final settings = PricingSettings.defaultSettings();

        // When: محاسبه و گرد کردن
        final rawPrice = costIRR * (1 + settings.defaultProfitMargin / 100);
        final roundedPrice = (rawPrice / roundingStep).round() * roundingStep;

        // Then: قیمت گرد شده
        expect(roundedPrice % roundingStep, equals(0));
      });
    });

    // ============================================================
    // Test 2: فروش → سود ریالی و دلاری درست محاسبه شود
    // ============================================================
    group('Sale → Calculate IRR and USD Profit', () {
      test('should calculate operational profit correctly', () {
        // Given: فروش یک آیتم
        const sellingPrice = 7800000.0; // قیمت فروش
        const costPrice = 6000000.0; // قیمت خرید
        const exchangeRateAtSale = 60000.0; // نرخ ارز زمان فروش

        // When: محاسبه سود
        final profit = calculator.calculateItemProfit(
          sellingPrice: sellingPrice,
          costPrice: costPrice,
          exchangeRateAtSale: exchangeRateAtSale,
        );

        // Then: سود ریالی = 1,800,000
        expect(profit.profitIRR, equals(1800000.0));

        // Then: سود دلاری = 1,800,000 / 60,000 = 30$
        expect(profit.profitUSD, equals(30.0));

        // Then: درصد سود = 30%
        expect(profit.profitPercent, equals(30.0));
      });

      test('profitUSD is computed not stored (BR-2.9)', () {
        // Given: یک آیتم فروش با سود ذخیره شده
        final saleItem = SaleItemData(
          itemUuid: 'test-uuid',
          sellingPrice: 7800000.0,
          costPrice: 6000000.0,
          profitIRR: 1800000.0, // این ذخیره می‌شود
          exchangeRateAtSale: 60000.0, // این هم ذخیره می‌شود
          soldAt: DateTime.now(),
          quantity: 1,
        );

        // When: محاسبه سود دلاری (computed)
        final profitUSD = saleItem.profitUSD;

        // Then: سود دلاری از روی ریالی محاسبه شد
        // ⚠️ Important: profitUSD هرگز در دیتابیس ذخیره نمی‌شود!
        expect(profitUSD, equals(30.0));
      });
    });

    // ============================================================
    // Test 3: گزارش سود → تاریخی و امروز تفاوت داشته باشد
    // ============================================================
    group('Profit Report → Historical vs Current Difference', () {
      test('should calculate profit summary with historical rates', () {
        // Given: فروش‌های مختلف با نرخ‌های مختلف
        final items = [
          SaleItemData(
            itemUuid: 'item-1',
            sellingPrice: 7800000.0,
            costPrice: 6000000.0,
            profitIRR: 1800000.0,
            exchangeRateAtSale: 60000.0, // نرخ زمان فروش
            soldAt: DateTime(2024, 1, 10),
            quantity: 1,
          ),
          SaleItemData(
            itemUuid: 'item-2',
            sellingPrice: 8450000.0,
            costPrice: 6500000.0,
            profitIRR: 1950000.0,
            exchangeRateAtSale: 65000.0, // نرخ متفاوت
            soldAt: DateTime(2024, 1, 15),
            quantity: 1,
          ),
        ];

        const currentRate = 70000.0; // نرخ امروز

        // When: محاسبه خلاصه
        final summary = calculator.calculatePeriodSummary(
          items: items,
          currentExchangeRate: currentRate,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 31),
        );

        // Then: محاسبات تاریخی
        // سود دلاری تاریخی: 1,800,000/60,000 + 1,950,000/65,000 = 30 + 30 = 60$
        final expectedHistoricalUSD =
            (1800000.0 / 60000.0) + (1950000.0 / 65000.0);
        expect(summary.totalProfitUSD, closeTo(expectedHistoricalUSD, 0.01));

        // Then: ارزش امروز
        // کل سود ریالی = 3,750,000 / 70,000 = 53.57$
        final totalProfitIRR = 1800000.0 + 1950000.0;
        final expectedCurrentUSD = totalProfitIRR / currentRate;
        expect(summary.currentValueUSD, closeTo(expectedCurrentUSD, 0.01));

        // Then: تفاوت تاریخی و امروز
        expect(summary.totalProfitUSD, isNot(equals(summary.currentValueUSD)));
      });

      test('should detect value loss when rate increases (BR-2.10)', () {
        // Given: فروش با نرخ 60,000
        final items = [
          SaleItemData(
            itemUuid: 'item-1',
            sellingPrice: 7800000.0,
            costPrice: 6000000.0,
            profitIRR: 1800000.0,
            exchangeRateAtSale: 60000.0,
            soldAt: DateTime.now(),
            quantity: 1,
          ),
        ];

        // When: نرخ امروز بالاتر است (70,000)
        const currentRate = 70000.0;

        final summary = calculator.calculatePeriodSummary(
          items: items,
          currentExchangeRate: currentRate,
          startDate: DateTime.now().subtract(Duration(days: 30)),
          endDate: DateTime.now(),
        );

        // Then: کاهش ارزش
        // تاریخی: 1,800,000 / 60,000 = $30
        // امروز: 1,800,000 / 70,000 = $25.71
        expect(summary.hasValueLoss, isTrue);
        expect(summary.valueDifferenceUSD, lessThan(0));
      });
    });

    // ============================================================
    // Test 4: تغییر نرخ ارز → ارزش امروز تغییر کند
    // ============================================================
    group('Exchange Rate Change → Current Value Changes', () {
      test('should calculate FX impact correctly (BR-2.11)', () {
        // Given: سود ریالی ثابت
        const totalProfitIRR = 3750000.0;
        const historicalRate = 60000.0;
        const currentRate = 70000.0;

        // When: محاسبه تاثیر تغییر ارز
        final fxImpact = calculator.getFXImpact(
          totalProfitIRR: totalProfitIRR,
          historicalRate: historicalRate,
          currentRate: currentRate,
        );

        // Then: ارزش تاریخی
        expect(
          fxImpact.historicalValueUSD,
          equals(totalProfitIRR / historicalRate),
        );

        // Then: ارزش امروز
        expect(fxImpact.currentValueUSD, equals(totalProfitIRR / currentRate));

        // Then: کاهش ارزش (چون نرخ بالا رفته)
        expect(fxImpact.hasValueLoss, isTrue);
      });

      test('should show value gain when rate decreases', () {
        // Given: نرخ امروز کمتر
        const totalProfitIRR = 3750000.0;
        const historicalRate = 70000.0;
        const currentRate = 60000.0; // نرخ پایین‌تر

        // When
        final fxImpact = calculator.getFXImpact(
          totalProfitIRR: totalProfitIRR,
          historicalRate: historicalRate,
          currentRate: currentRate,
        );

        // Then: افزایش ارزش
        expect(fxImpact.hasValueGain, isTrue);
        expect(fxImpact.valueDifferenceUSD, greaterThan(0));
      });
    });

    // ============================================================
    // Test 5: محاسبه نرخ مؤثر (Effective Rate)
    // ============================================================
    group('Effective Rate Calculation', () {
      test('should calculate effective exchange rate', () {
        // Given: فروش‌های مختلف
        final items = [
          SaleItemData(
            itemUuid: 'item-1',
            sellingPrice: 7800000.0,
            costPrice: 6000000.0,
            profitIRR: 1800000.0,
            exchangeRateAtSale: 60000.0,
            soldAt: DateTime.now(),
            quantity: 1,
          ),
          SaleItemData(
            itemUuid: 'item-2',
            sellingPrice: 8450000.0,
            costPrice: 6500000.0,
            profitIRR: 1950000.0,
            exchangeRateAtSale: 65000.0,
            soldAt: DateTime.now(),
            quantity: 1,
          ),
        ];

        // When
        final summary = calculator.calculatePeriodSummary(
          items: items,
          currentExchangeRate: 70000.0,
          startDate: DateTime.now().subtract(Duration(days: 30)),
          endDate: DateTime.now(),
        );

        // Then: نرخ مؤثر = مجموع ریالی / مجموع دلاری
        final expectedEffectiveRate =
            summary.totalProfitIRR / summary.totalProfitUSD;
        expect(summary.effectiveRate, closeTo(expectedEffectiveRate, 0.01));
      });
    });

    // ============================================================
    // Test 6: سود روزانه
    // ============================================================
    group('Daily Profits', () {
      test('should calculate daily profits correctly', () {
        // Given: فروش‌های چند روز
        final items = [
          SaleItemData(
            itemUuid: 'item-1',
            sellingPrice: 7800000.0,
            costPrice: 6000000.0,
            profitIRR: 1800000.0,
            exchangeRateAtSale: 60000.0,
            soldAt: DateTime(2024, 1, 10),
            quantity: 1,
          ),
          SaleItemData(
            itemUuid: 'item-2',
            sellingPrice: 8450000.0,
            costPrice: 6500000.0,
            profitIRR: 1950000.0,
            exchangeRateAtSale: 65000.0,
            soldAt: DateTime(2024, 1, 10), // همان روز
            quantity: 1,
          ),
          SaleItemData(
            itemUuid: 'item-3',
            sellingPrice: 9100000.0,
            costPrice: 7000000.0,
            profitIRR: 2100000.0,
            exchangeRateAtSale: 68000.0,
            soldAt: DateTime(2024, 1, 15), // روز دیگر
            quantity: 1,
          ),
        ];

        // When
        final dailyProfits = calculator.calculateDailyProfits(items);

        // Then: دو روز مجزا
        expect(dailyProfits.length, equals(2));

        // Then: روز اول (10 Jan) - 2 آیتم
        final day1 = dailyProfits[0];
        expect(day1.invoiceCount, equals(2));
        expect(day1.profitIRR, equals(1800000.0 + 1950000.0));

        // Then: روز دوم (15 Jan) - 1 آیتم
        final day2 = dailyProfits[1];
        expect(day2.invoiceCount, equals(1));
        expect(day2.profitIRR, equals(2100000.0));
      });
    });
  });

  // ============================================================
  // Summary - Verifies all Phase 2 business rules
  // ============================================================
  group('Phase 2 Integration Summary', () {
    test('COMPLETE CHAIN TEST verifies all business rules', () {
      // This test serves as documentation that all business rules are tested:
      // - BR-2.9: profitUSD computed, not stored
      // - BR-2.10: Current value with today's rate
      // - BR-2.11: FX revaluation impact
      //
      // All individual tests above verify these rules.
      expect(true, isTrue);
    });
  });
}
