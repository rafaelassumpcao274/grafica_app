import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum CurrencyFormatType {
  decimalOnly, // 1234.56
  integerWithDecimal, // 1.234,56
  full, // 1.234,56 com símbolo opcional
}

class CurrencyInputFormatter extends TextInputFormatter {
  final CurrencyFormatType formatType;
  final int decimalDigits;
  final String symbol;

  CurrencyInputFormatter({
    this.formatType = CurrencyFormatType.full,
    this.decimalDigits = 2,
    this.symbol = '',
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove tudo que não for dígito
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.isEmpty) {
      return const TextEditingValue(text: '');
    }

    double value = double.parse(digitsOnly) / 100;

    String newText;

    switch (formatType) {
      case CurrencyFormatType.decimalOnly:
        newText = value.toStringAsFixed(decimalDigits);
        break;

      case CurrencyFormatType.integerWithDecimal:
      // Sem símbolo, mas com separador de milhares e vírgula decimal
        final formatter = NumberFormat("#,##0.${'0' * decimalDigits}", "pt_BR");
        newText = formatter.format(value);
        break;

      case CurrencyFormatType.full:
      // Com símbolo de moeda
        final formatter = NumberFormat.currency(
          locale: 'pt_BR',
          symbol: symbol,
          decimalDigits: decimalDigits,
        );
        newText = formatter.format(value);
        break;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

