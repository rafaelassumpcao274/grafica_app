import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:unilith_app/features/ordemServico/domain/vos/currency.dart';

import '../../core/formatter/currency_input_formatter.dart';


class CustomDecimalInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool enabled;
  final String? Function(String?)? validator;

  const CustomDecimalInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.enabled = true,
    this.validator,
  });

  @override
  State<CustomDecimalInput> createState() => _CustomDecimalInputState();
}

class _CustomDecimalInputState extends State<CustomDecimalInput> {


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyInputFormatter(),
      ],
      validator: widget.validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Informe um valor';
            }

            try {
              Currency(value);
              return null;
            } catch (_) {
              return 'Valor inválido';
            }
          },
      decoration: InputDecoration(
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
        prefixText: 'R\$ ',
        labelText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
