import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CpfCnpjFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final FormFieldValidator<String>? validator;

  const CpfCnpjFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.validator,
  });

  String _formatCpfCnpj(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');
    if (value.length < 11) {
      return value; // Not enough digits for CPF or CNPJ
    }
    if (value.length == 11) {
      // CPF: 000.000.000-00
      return value.replaceAllMapped(
        RegExp(r'^(\d{0,3})(\d{0,3})?(\d{0,3})?(\d{0,2})?'),
        (m) => [
          if (m[1]!.isNotEmpty) m[1],
          if (m[2]!.isNotEmpty) '.${m[2]}',
          if (m[3]!.isNotEmpty) '.${m[3]}',
          if (m[4]!.isNotEmpty) '-${m[4]}',
        ].join(),
      );
    } else {
      // CNPJ: 00.000.000/0000-00
      return value.replaceAllMapped(
        RegExp(r'^(\d{0,2})(\d{0,3})?(\d{0,3})?(\d{0,4})?(\d{0,2})?'),
        (m) => [
          if (m[1]!.isNotEmpty) m[1],
          if (m[2]!.isNotEmpty) '.${m[2]}',
          if (m[3]!.isNotEmpty) '.${m[3]}',
          if (m[4]!.isNotEmpty) '/${m[4]}',
          if (m[5]!.isNotEmpty) '-${m[5]}',
        ].join(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label ?? 'Documento (CPF/CNPJ)',
        border: const OutlineInputBorder(),
        prefix: Icon(Icons.article_outlined)
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Informe um documento válido';
            }
            return null;
          },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
      maxLength: 18,
    );
  }
}
