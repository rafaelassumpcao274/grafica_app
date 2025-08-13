import 'package:flutter/services.dart';

import 'document_formatter.dart';

class DocumentInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {

    String value = newValue.text.replaceAll(RegExp(r'\D'), '');

    value = DocumentFormatter.formatter(value);

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }


}
