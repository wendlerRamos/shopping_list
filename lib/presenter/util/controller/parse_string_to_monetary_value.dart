import 'package:intl/intl.dart';

abstract class ParseStringToMonetaryValue {
  String execute(String originalValue);
}

class ParseStringToMonetaryValueImplementation implements ParseStringToMonetaryValue {
  @override
  String execute(String originalValue) {
    final numberFormat = NumberFormat.currency(locale: "pt_BR", name: "R\$", decimalDigits: 2);
    final parsedValueToDouble = double.tryParse(originalValue);
    return numberFormat.format(parsedValueToDouble);
  }
}
