import 'package:flutter/material.dart';

import '../../../domain/fatura_resumo_dto.dart';
import '../../core/theme.dart';

class FaturaCard extends StatelessWidget {
  final FaturaResumoDto fatura;
  final VoidCallback onTap;

  const FaturaCard({super.key, required this.fatura, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: AppColors.mediumGray.withValues(alpha: 0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIcon(),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${fatura.id} - ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: AppColors.primaryBlue,
                                        fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  fatura.clienteNome ?? 'Sem cliente',
                                  style: Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            fatura.osNumeroMaterial != null
                                ? 'OS: ${fatura.osNumeroMaterial}'
                                : 'Sem OS vinculada',
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      fatura.status,
                      style: TextStyle(
                        color: _statusColor(fatura.status),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
          colors: [
            AppColors.primaryBlue.withValues(alpha: 0.15),
            AppColors.accentPurple.withValues(alpha: 0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Icons.receipt_long, color: AppColors.primaryBlue, size: 26),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.attach_money, size: 16, color: AppColors.textGray),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'Total: R\$ ${fatura.valorTotal.toStringAsFixed(2)} • Recebido: R\$ ${fatura.totalRecebido.toStringAsFixed(2)} • Saldo: R\$ ${fatura.saldo.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textGray,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'PAGA':
        return AppColors.success;
      case 'PARCIAL':
        return AppColors.primaryBlue;
      default: // ABERTA
        return AppColors.warning;
    }
  }
}
