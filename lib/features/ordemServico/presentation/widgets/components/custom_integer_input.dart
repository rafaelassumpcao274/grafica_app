import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomIntegerInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool useThousandsSeparator; // nova opção para formatação de milhares

  const CustomIntegerInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.validator,
    this.enabled = true,
    this.useThousandsSeparator = false,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [FilteringTextInputFormatter.digitsOnly];

    if(controller.text.isNotEmpty){
      controller.text = ThousandsFormatter().ThousandsFormatNumber(controller.text);
    }

    if (useThousandsSeparator) {
      // Formata com separador de milhar
      inputFormatters.add(ThousandsFormatter());
    }

    return TextFormField(
      controller: controller,
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return 'Informe um valor';
            }
            final number = int.tryParse(value.replaceAll('.', ''));
            if (number == null) return 'Valor inválido';
            return null;
          },
      enabled: enabled,
      keyboardType: TextInputType.number,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        labelText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

// Formatter simples de milhares
class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.isEmpty) return const TextEditingValue(text: '');

    String newText = ThousandsFormatNumber(digitsOnly);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String ThousandsFormatNumber(String digitsOnly) {
       final number = int.parse(digitsOnly);
    final newText = NumberFormat('#,###', 'pt_BR').format(number);
    return newText;
  }
}
