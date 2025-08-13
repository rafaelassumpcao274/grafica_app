import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

class DocumentFormatter {




  static String formatter(String value){

    value = value.replaceAll(RegExp(r'\D'), '');
    if (value.length < 11 || (value.length > 11 && value.length < 14)) {
      return  value;
    }
    if (value.length == 11) {
      // CPF: 000.000.000-00
      return CPFValidator.format(value);
    }
      // CNPJ: 00.000.000/0000-00
     return CNPJValidator.format(value);

  }


}