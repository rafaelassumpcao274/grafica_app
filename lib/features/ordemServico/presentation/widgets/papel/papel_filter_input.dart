import 'package:flutter/material.dart';

import '../../core/theme.dart';
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
              hintText: 'Buscar Papeis ...',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              prefixIcon: Icon(Icons.search, color: AppColors.textGray, size: 22),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(child: PapelList(filter: _filter)),
      ],
    );
  }
}
