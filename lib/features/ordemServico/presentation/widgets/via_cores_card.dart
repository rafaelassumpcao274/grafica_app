import 'package:flutter/material.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/clientes.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/via_cores/edit/via_cores_form_page.dart';

import '../../domain/entities/via_cores.dart';
import '../core/theme.dart';


class ViaCoresCard extends StatelessWidget {
  final ViaCores viaCores;

  const ViaCoresCard({super.key, required this.viaCores});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.mediumGray.withValues(alpha: 0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ViaCoresForm(viacoresId: viaCores.id,),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                _buildAvatar(),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(viaCores.descricao, style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.textGray),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.accentPurple.withValues(alpha: 0.15), AppColors.accentPink.withValues(alpha: 0.15)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          viaCores.descricao.isNotEmpty ? viaCores.descricao[0].toUpperCase() : '?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.accentPurple,
          ),
        ),
      ),
    );
  }



}