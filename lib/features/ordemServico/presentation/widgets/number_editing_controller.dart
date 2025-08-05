import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberEditingController<T extends num> extends TextEditingController {
  final NumberFormat _formatter;
  final bool isDecimal;

  NumberEditingController({T? value})
      : isDecimal = T == double,
        _formatter = NumberFormat.currency(
          locale: 'pt_BR',
          symbol: '',
          decimalDigits: T == double ? 2 : 0,
        ),
        super(
          text: value != null
              ? NumberFormat.currency(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: T == double ? 2 : 0)
                  .format(value)
              : '',
        );

  /// Retorna o valor como `T`
  T? get number {
    final raw = text.trim();

    if (isDecimal) {

      final parsed =_formatter.parse(text);
      return parsed != null ? parsed as T : null;
    } else {
      final cleaned = raw.replaceAll('.', '').replaceAll(',', '.');
      final parsed = int.tryParse(cleaned);
      return parsed != null ? parsed as T : null;
    }
  }

  /// Define o valor programaticamente
  void setNumber(T value) {
    text = _formatter.format(value);
  }

  /// Valida o valor atual
  String? validate([String? value]) {
    final raw = (value ?? text).trim();
    final cleaned = raw.replaceAll('.', '').replaceAll(',', '.');

    if (isDecimal) {
      return double.tryParse(cleaned) == null
          ? 'Digite um valor decimal válido'
          : null;
    } else {
      return int.tryParse(cleaned) == null
          ? 'Digite um número inteiro válido'
          : null;
    }
  }
}
