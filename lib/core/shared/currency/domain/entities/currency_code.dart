enum CurrencyCode {
  rial,
  toman,
  dollar,
  euro,
  dinar,
  dirham,
  lira,
  yuan,
  pound,
}

extension CurrencyCodeExtension on CurrencyCode {
  String get name {
    switch (this) {
      case CurrencyCode.rial:
        return 'ریال';
      case CurrencyCode.toman:
        return 'تومان';
      case CurrencyCode.dollar:
        return 'دلار';
      case CurrencyCode.euro:
        return 'یورو';
      case CurrencyCode.dinar:
        return 'دینار';
      case CurrencyCode.dirham:
        return 'درهم';
      case CurrencyCode.lira:
        return 'لیر';
      case CurrencyCode.yuan:
        return 'یوان';
      case CurrencyCode.pound:
        return 'پوند';
    }
  }

  String get symbol {
    switch (this) {
      case CurrencyCode.rial:
        return 'ریال';
      case CurrencyCode.toman:
        return 'تومان';
      case CurrencyCode.dollar:
        return '\$';
      case CurrencyCode.euro:
        return '€';
      case CurrencyCode.dinar:
        return 'د.ع';
      case CurrencyCode.dirham:
        return 'د.إ';
      case CurrencyCode.lira:
        return '₺';
      case CurrencyCode.yuan:
        return '¥';
      case CurrencyCode.pound:
        return '£';
    }
  }
}
