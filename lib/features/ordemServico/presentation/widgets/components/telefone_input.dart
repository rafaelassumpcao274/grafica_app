import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TelefoneInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  TelefoneInput({super.key, required this.controller, this.validator});

  final _formatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: { "#": RegExp(r'[0-9]') },
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [_formatter],
      decoration: const InputDecoration(
        labelText: 'Telefone',
        hintText: '(99) 99999-9999',
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
