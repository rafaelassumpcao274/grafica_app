import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/formatter/document_input_formatter.dart';

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
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefix: Icon(Icons.article_outlined),
        labelText:'Documento (CPF/CNPJ)',
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DocumentInputFormatter()
      ],
      onChanged: onChange,
      keyboardType: TextInputType.number,
      maxLength: 18,
    );
  }
}

