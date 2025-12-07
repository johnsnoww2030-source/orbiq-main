import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';

abstract class CurrencyRepository {
  Future<CurrencyCode> getSelectedCurrency();
  Future<void> saveSelectedCurrency(CurrencyCode currency);
  Future<Map<CurrencyCode, double>> getcurrencyRates();
  Future<void> saveCurrencyRates(Map<CurrencyCode, double> rates);
}
