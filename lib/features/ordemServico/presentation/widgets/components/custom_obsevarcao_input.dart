import 'package:flutter/material.dart';

import '../../core/theme.dart';

class CustomObservacaoInput extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomObservacaoInput({
    super.key,
    required this.controller,
    this.icon,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mediumGray.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child:
      TextFormField(
        controller: controller,
        maxLines: 4,
        style:
        TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: 'Observações adicionais...',
          hintStyle: TextStyle(color: AppColors.textGray, fontSize: 15),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
