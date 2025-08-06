import 'package:flutter/material.dart';

import '../../pages/fornecedor/list/fornecedor_list.dart';


class FornecedorFilterInput extends StatefulWidget {
  const FornecedorFilterInput({super.key});

  @override
  State<FornecedorFilterInput> createState() =>
      _FornecedorFilterInputState();
}

class _FornecedorFilterInputState extends State<FornecedorFilterInput> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Filtrar Fornecedor',
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
        Expanded(child: FornecedorList(filter: _filter)),
      ],
    );
  }
}
