import 'package:unilith_app/features/ordemServico/domain/vos/value_object.dart';

class Tamanho extends ValueObject {
  final double _altura;
  final double _largura;

  Tamanho(String dimensionStr)
      : _altura = _parseDimension(dimensionStr).$1,
        _largura = _parseDimension(dimensionStr).$2 {
    if (_altura <= 0 || _largura <= 0) {
      throw ArgumentError('Altura e largura devem ser maiores que zero.');
    }
  }

  static (double, double) _parseDimension(String value) {
    if(value.isEmpty || value == 'null'){
      return (0.0,0.0);
    }

    final parts = value.toLowerCase().split('x');
    if (parts.length != 2) {
      throw ArgumentError('Formato inválido. Use o padrão AlturaXlargura, ex: "15x21".');
    }

    final height = double.tryParse(parts[0].trim().replaceAll(',', '.'));
    final width = double.tryParse(parts[1].trim().replaceAll(',', '.'));

    if (height == null || width == null) {
      throw ArgumentError('Altura e largura devem ser números válidos.');
    }

    return (height, width);
  }

  @override
  String toString() => "${_altura}x${_largura}";

  @override
  String? validator() {
    final double? parsedHeight = _altura;
    final double? parsedWidth = _largura;

    if (parsedHeight == null || parsedWidth == null) {
      return 'Altura e largura devem ser números válidos.';
    }

    if (parsedHeight <= 0 || parsedWidth <= 0) {
      return 'Altura e largura devem ser maiores que zero.';
    }

    return null;
  }
}
