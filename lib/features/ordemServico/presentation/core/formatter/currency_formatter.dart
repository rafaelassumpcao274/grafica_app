import 'package:intl/intl.dart';

class CurrencyFormatter{
  static final NumberFormat _formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: '',
    decimalDigits: 2,
  );


  static String formatterToString(double value){
    return _formatter.format(value);
  }

  static double formatterToDouble(String value) {
    var  parsed = 0.0;
    if(value.contains(',')){
      parsed =  _formatter.parse(value) as double;
    }else{
      parsed = double.parse(value);
    }

    return parsed;
  }




}