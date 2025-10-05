import 'package:flutter/material.dart';

import '../../core/theme.dart';
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
              hintText: 'Filtrar Ordem de Serviço',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              prefixIcon: Icon(Icons.search, color: AppColors.textGray, size: 22),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(child: OrdemServicoList(filter: _filter)),
      ],
    );



  }
}
