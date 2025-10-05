import 'package:flutter/material.dart';

import '../../core/theme.dart';
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _filter = value;
              });
            },
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Buscar fornecedor...',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              prefixIcon: Icon(Icons.search, color: AppColors.textGray, size: 22),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(child: ClientList(filter: _filter)),
      ],
    );
  }
}
