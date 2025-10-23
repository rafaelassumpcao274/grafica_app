import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../core/theme.dart';

class TelefoneInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  TelefoneInput({super.key, required this.controller, this.validator});

  final _formatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: AppColors.mediumGray.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.phone,
          inputFormatters: [_formatter],
          decoration: const InputDecoration(
              hintText: 'Telefone',
              hintStyle: TextStyle(color: AppColors.textGray, fontSize: 15),
              prefixIcon: Icon(Icons.add_ic_call_outlined,
                  color: AppColors.textGray, size: 20),
              prefixStyle: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
          validator: validator,
        ));
  }
}
