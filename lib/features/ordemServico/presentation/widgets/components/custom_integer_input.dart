import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomIntegerInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomIntegerInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Informe um valor';
            }
            final number = int.tryParse(value.replaceAll('.', '').replaceAll(',', ''));
            if (number == null) return 'Valor inválido';
            return null;
          },
      enabled: enabled,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
