import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:orbiq/core/shared/currency/domain/entities/currency_code.dart';

class CurrencyLocalDataSource {
  static const String _selectedCurrencyKey = 'selected_currency';
  static const String _currencyRatesKey = 'currency_rates';

  Future<CurrencyCode> getSelectedCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final String? currencyName = prefs.getString(_selectedCurrencyKey);
    if (currencyName != null) {
      try {
        return CurrencyCode.values.firstWhere((e) => e.name == currencyName);
      } catch (_) {
        return CurrencyCode.toman;
      }
    }
    return CurrencyCode.toman;
  }

  Future<void> saveSelectedCurrency(CurrencyCode currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedCurrencyKey, currency.name);
  }

  Future<Map<CurrencyCode, double>> getCurrencyRates() async {
    final prefs = await SharedPreferences.getInstance();
    final String? ratesJson = prefs.getString(_currencyRatesKey);

    // Default rates
    final Map<CurrencyCode, double> rates = {
      for (var code in CurrencyCode.values) code: 1.0,
    };

    if (ratesJson != null) {
      try {
        final Map<String, dynamic> decoded = json.decode(ratesJson);
        decoded.forEach((key, value) {
          try {
            final code = CurrencyCode.values.firstWhere((e) => e.name == key);
            rates[code] = (value as num).toDouble();
          } catch (_) {}
        });
      } catch (_) {}
    }
    return rates;
  }

  Future<void> saveCurrencyRates(Map<CurrencyCode, double> rates) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, double> ratesMap = {};
    rates.forEach((key, value) {
      ratesMap[key.name] = value;
    });
    await prefs.setString(_currencyRatesKey, json.encode(ratesMap));
  }
}
