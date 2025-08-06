enum TipoServico {
  distribuidora,
  prestadorDeServico,
}

extension TipoServicoExtension on TipoServico {
  String get label {
    switch (this) {
      case TipoServico.distribuidora:
        return 'Distribuidora';
      case TipoServico.prestadorDeServico:
        return 'Prestador de Serviço';
    }
  }

  static TipoServico? fromString(String value) {
    switch (value.toLowerCase()) {
      case 'distribuidora':
        return TipoServico.distribuidora;
      case 'prestador de serviço':
        return TipoServico.prestadorDeServico;
      default:
        return null;
    }
  }
}
