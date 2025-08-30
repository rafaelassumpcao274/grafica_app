import 'package:unilith_app/features/ordemServico/presentation/core/formatter/currency_formatter.dart';

class Currency{

  final double _value;

  Currency( String? currency): _value = currency!.isNotEmpty ? CurrencyFormatter.formatterToDouble(currency): 0.0;

  double toDouble() => _value;

  @override
  String toString() => CurrencyFormatter.formatterToString(_value);
}