import 'package:flutter/material.dart';

import '../../pages/cliente/list/cliente_list.dart';



class ClientFilterInput extends StatefulWidget {
  const ClientFilterInput({super.key});

  @override
  State<ClientFilterInput> createState() => _ClientFilterInputState();
}

class _ClientFilterInputState extends State<ClientFilterInput> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Filtrar clientes',
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
        Expanded(child: ClientList(filter: _filter)),
      ],
    );
  }
}
