import 'package:flutter/material.dart';

import '../../pages/ordem_servico/list/ordem_servico_list.dart';


class OrdemServicoFilterInput extends StatefulWidget {
  const OrdemServicoFilterInput({super.key});

  @override
  State<OrdemServicoFilterInput> createState() =>
      _OrdemServicoFilterInputState();
}

class _OrdemServicoFilterInputState extends State<OrdemServicoFilterInput> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Filtrar Ordem de Serviço',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _filter = value;
            });
          },
        ),
        const SizedBox(height: 8),
        Expanded(child: OrdemServicoList(filter: _filter)),
      ],
    );
  }
}
