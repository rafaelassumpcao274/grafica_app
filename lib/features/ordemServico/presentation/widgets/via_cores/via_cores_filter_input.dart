import 'package:flutter/material.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/via_cores/list/via_cores_list.dart';

import '../../core/theme.dart';
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
              hintText: 'Buscar Cores ...',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              prefixIcon: Icon(Icons.search, color: AppColors.textGray, size: 22),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(child: ViaCoresList(filter: _filter)),
      ],
    );
  }
}
