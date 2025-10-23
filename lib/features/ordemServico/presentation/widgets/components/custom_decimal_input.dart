import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:unilith_app/features/ordemServico/domain/vos/currency.dart';

import '../../core/formatter/currency_input_formatter.dart';
import '../../core/theme.dart';

class CustomDecimalInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool enabled;
  final String? Function(String?)? validator;
  final CurrencyFormatType currencyFormatType;
  final void Function(String)? onChanged;

  const CustomDecimalInput(
      {super.key,
      required this.controller,
      required this.hintText,
      this.icon,
      this.enabled = true,
      this.validator,
      this.onChanged,
      CurrencyFormatType? formatType})
      : currencyFormatType = formatType ?? CurrencyFormatType.full;

  @override
  State<CustomDecimalInput> createState() => _CustomDecimalInputState();
}

class _CustomDecimalInputState extends State<CustomDecimalInput> {
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
      child: TextFormField(
        controller: widget.controller,
        enabled: widget.enabled,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
        ],
        style: widget.enabled ? TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark):
          TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.textGray),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColors.textGray, fontSize: 15),
          prefixIcon: Icon(widget.icon, color: AppColors.textGray, size: 20),
          prefixText: 'R\$ ',
          prefixStyle: TextStyle(
              color: AppColors.textDark,
              fontSize: 15,
              fontWeight: FontWeight.w600),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
