import 'package:flutter/material.dart';

import '../../pages/fornecedor/list/fornecedor_list.dart';
import '../../pages/papel/list/papel_list.dart';


class PapelFilterInput extends StatefulWidget {
  const PapelFilterInput({super.key});

  @override
  State<PapelFilterInput> createState() =>
      _PapelFilterInputState();
}

class _PapelFilterInputState extends State<PapelFilterInput> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Filtrar Papel',
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
        Expanded(child: PapelList(filter: _filter)),
      ],
    );
  }
}
