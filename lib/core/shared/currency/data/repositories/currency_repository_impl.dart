import 'package:orbiq/core/shared/currency/data/data_sources/currency_local_data_source.dart';
import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';
import 'package:orbiq/core/shared/currency/domain/repositories/currency_repository.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyLocalDataSource dataSource;

  CurrencyRepositoryImpl(this.dataSource);

  @override
  Future<CurrencyCode> getSelectedCurrency() =>
      dataSource.getSelectedCurrency();

  @override
  Future<void> saveSelectedCurrency(CurrencyCode currency) =>
      dataSource.saveSelectedCurrency(currency);

  @override
  Future<Map<CurrencyCode, double>> getcurrencyRates() =>
      dataSource.getCurrencyRates();

  @override
  Future<void> saveCurrencyRates(Map<CurrencyCode, double> rates) =>
      dataSource.saveCurrencyRates(rates);
}
