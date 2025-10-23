import 'package:flutter/material.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/clientes.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/via_cores/edit/via_cores_form_page.dart';

import '../../domain/entities/via_cores.dart';
import '../core/theme.dart';


class ViaCoresCard extends StatelessWidget {
  final ViaCores viaCores;
  final VoidCallback? onEdit;
  final VoidCallback? onRemove;


  const ViaCoresCard({
    super.key,
    required this.viaCores,
    this.onEdit,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // Card modo "item existente"
    return ListTile(
      title: Text(
        viaCores.descricao,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      leading: const Icon(Icons.color_lens_outlined, color: AppColors.primaryBlue),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: AppColors.accentPurple),
              onPressed: onEdit,
            ),
          if (onRemove != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: onRemove,
            ),
        ],
      ),
      onTap: onEdit,
    );
  }
}
