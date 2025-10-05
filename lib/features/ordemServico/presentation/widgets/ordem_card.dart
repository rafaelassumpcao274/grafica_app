import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/ordemservico.dart';

import '../core/theme.dart';
import '../pages/ordem_servico/edit/ordem_servico_form_page.dart';

class OrdemCard extends StatelessWidget {
  final OrdemServico ordem;

  const OrdemCard({super.key, required this.ordem});

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
      child:

      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OrdemServicoForm(ordemId: ordem.id),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildIcon(),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('${ordem.id} - ', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                              Text(ordem.clientes!.nomeEmpresa, style: Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(ordem.material, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    // _buildStatusBadge(),
                  ],
                ),
                SizedBox(height: 16),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildIcon() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryBlue.withValues(alpha: 0.15), AppColors.accentPurple.withValues(alpha: 0.15)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Icons.description_outlined, color: AppColors.primaryBlue, size: 26),
    );
  }

  // Widget _buildStatusBadge() {
  //   final statusInfo = _getStatusInfo();
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //     decoration: BoxDecoration(
  //       color: statusInfo['color'].withValues(alpha: 0.12),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Text(
  //       statusInfo['text'],
  //       style: TextStyle(
  //         color: statusInfo['color'],
  //         fontSize: 11,
  //         fontWeight: FontWeight.w600,
  //         letterSpacing: 0.5,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time_outlined, size: 16, color: AppColors.textGray),
          SizedBox(width: 6),
          Text(
            'Criado em: ${DateFormat('dd/MM/yyyy HH:mm').format(ordem.createdAt!)}',
            style: TextStyle(fontSize: 12, color: AppColors.textGray, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Map<String, dynamic> _getStatusInfo() {
  //   switch (ordem.status) {
  //     case StatusOrdem.pendente:
  //       return {'text': 'PENDENTE', 'color': AppColors.warning};
  //     case StatusOrdem.emAndamento:
  //       return {'text': 'EM ANDAMENTO', 'color': AppColors.primaryBlue};
  //     case StatusOrdem.concluido:
  //       return {'text': 'CONCLUÍDO', 'color': AppColors.success};
  //     case StatusOrdem.cancelado:
  //       return {'text': 'CANCELADO', 'color': AppColors.error};
  //   }
  // }
}
