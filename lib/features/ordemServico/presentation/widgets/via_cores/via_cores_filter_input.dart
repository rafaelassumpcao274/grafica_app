import 'package:flutter/material.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/via_cores/list/via_cores_list.dart';

import '../../pages/fornecedor/list/fornecedor_list.dart';
import '../../pages/papel/list/papel_list.dart';


class ViaCoresFilterInput extends StatefulWidget {
  const ViaCoresFilterInput({super.key});

  @override
  State<ViaCoresFilterInput> createState() =>
      _ViaCoresFilterInputState();
}

class _ViaCoresFilterInputState extends State<ViaCoresFilterInput> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Filtrar Cores',
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
        Expanded(child: ViaCoresList(filter: _filter)),
      ],
    );
  }
}
