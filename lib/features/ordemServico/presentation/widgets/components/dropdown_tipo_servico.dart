import 'package:flutter/material.dart';

import '../../../domain/entities/enums/TipoServico.dart';

class TipoServicoDropdown extends StatefulWidget {
  final TipoServico? valorInicial;
  final void Function(TipoServico?) onChanged;

  const TipoServicoDropdown({
    super.key,
    this.valorInicial,
    required this.onChanged,
  });

  @override
  State<TipoServicoDropdown> createState() => _TipoServicoDropdownState();
}

class _TipoServicoDropdownState extends State<TipoServicoDropdown> {
  TipoServico? _selecionado;

  @override
  void initState() {
    super.initState();
    _selecionado = widget.valorInicial;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<TipoServico>(
      value: _selecionado,
      decoration: const InputDecoration(
        labelText: 'Tipo de Serviço',
        border: OutlineInputBorder(),
      ),
      items: TipoServico.values.map((tipo) {
        return DropdownMenuItem(
          value: tipo,
          child: Text(tipo.label),
        );
      }).toList(),
      onChanged: (TipoServico? novoValor) {
        setState(() {
          _selecionado = novoValor;
        });
        widget.onChanged(novoValor);
      },
    );
  }
}
