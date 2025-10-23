import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/formatter/document_input_formatter.dart';
import '../../core/theme.dart';

class CpfCnpjFormField extends StatelessWidget{
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final TextEditingController controller;


  CpfCnpjFormField({
    super.key,
    this.validator,
    this.onChange,
    required  this.controller
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
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textDark),
            decoration: InputDecoration(
              hintText:'Documento (CPF/CNPJ)',
              filled: true,
              fillColor: Colors.white,
                hintStyle: TextStyle(color: AppColors.textGray, fontSize: 15),
                prefixIcon: Icon(Icons.art_track, color: AppColors.textGray, size: 20),
                prefixStyle: TextStyle(color: AppColors.textDark, fontSize: 15, fontWeight: FontWeight.w600),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16)
            ),
            validator: validator,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              DocumentInputFormatter()
            ],
            onChanged: onChange,
            keyboardType: TextInputType.number,
            maxLength: 18,
          )

      );
  }
}

