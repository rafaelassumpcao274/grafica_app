import 'package:flutter/material.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/enums/TipoServico.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/fornecedor/edit/fornecedor_form_page.dart';

import '../../domain/entities/fornecedor.dart';
import '../core/theme.dart';

class FornecedorCard extends StatelessWidget {
  final Fornecedor fornecedor;

  const FornecedorCard({super.key, required this.fornecedor});

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
                    FornecedorForm(fornecedorId: fornecedor.id,),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                _buildIcon(),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(fornecedor.nome, style: Theme.of(context).textTheme.titleMedium)),
                          if (fornecedor.tipoServico != null) _buildCategoriaBadge(),
                        ],
                      ),
                      if (fornecedor.telefone != null) ...[
                        SizedBox(height: 6),
                        _buildInfoRow(Icons.phone_outlined, fornecedor.telefone!),
                      ],
                      if (fornecedor.email != null) ...[
                        SizedBox(height: 4),
                        _buildInfoRow(Icons.email_outlined, fornecedor.email!),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.chevron_right, color: AppColors.textGray),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFA726).withValues(alpha: 0.15), Color(0xFFFF7043).withValues(alpha: 0.15)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Icons.business_outlined, color: Color(0xFFFF7043), size: 28),
    );
  }

  Widget _buildCategoriaBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        fornecedor.tipoServico.label!,
        style: TextStyle(
          color: AppColors.primaryBlue,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textGray),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: AppColors.textGray),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
