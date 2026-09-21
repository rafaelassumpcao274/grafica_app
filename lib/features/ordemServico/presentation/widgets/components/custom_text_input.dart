import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart' show Symbols;

import '../../core/theme.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final String? Function(String?)? validator;
  final bool enabled;

  /// Executado quando o texto é alterado.
  final ValueChanged<String>? onChange;

  /// Executado quando o campo é tocado.
  final VoidCallback? onTap;

  /// Quando true, o campo não permite digitação.
  final bool readOnly;

  /// Quando true, mostra o ícone de seleção no final do campo.
  final bool showBottomSheetIcon;

  const CustomTextInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.validator,
    this.enabled = true,
    this.onChange,
    this.onTap,
    this.readOnly = false,
    this.showBottomSheetIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.mediumGray.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChange,
        onTap: onTap,
        validator: validator,
        enabled: enabled,
        readOnly: readOnly,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.textGray,
            fontSize: 15,
          ),
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: AppColors.textGray,
                  size: 20,
                )
              : null,
          suffixIcon: showBottomSheetIcon
              ? Icon(
                  Symbols.bottom_panel_open_rounded,
                  size: 22,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
