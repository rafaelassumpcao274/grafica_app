import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:unilith_app/features/ordemServico/domain/vos/value_object.dart';

class Documento implements ValueObject {
  final String _value;

  Documento(this._value);

  @override
  String? validator(){

    if(_value.contains('[.\-\/]')){

      if(_value.length < 15){
        if (!CPFValidator.isValid(_value)) {
          return 'Documento não é válido';
        }
      }else{
        if (!CNPJValidator.isValid(_value)) {
          return 'Documento não é válido';
        }
      }
    }

    return null;
  }

  @override
  String toString() => _value;

  String toStringOnlyNumbers() => _value.replaceAll(RegExp(r'[^\d]'), '');
}