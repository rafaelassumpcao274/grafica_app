import 'package:flutter/material.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/clientes.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/cliente/edit/client_form_page.dart';

import '../core/theme.dart';


class ClienteCard extends StatelessWidget {
  final Clientes cliente;

  const ClienteCard({super.key, required this.cliente});

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
                    ClientForm(clienteId: cliente.id,),
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
                      Text(cliente.nomeEmpresa, style: Theme.of(context).textTheme.titleMedium),
                      if (cliente.documento != null) ...[
                        SizedBox(height: 6),
                        _buildInfoRow(Icons.art_track, cliente.documento!),
                      ],
                      if (cliente.email != null) ...[
                        SizedBox(height: 4),
                        _buildInfoRow(Icons.email_outlined, cliente.email!),
                      ],
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
          cliente.nomeEmpresa.isNotEmpty ? cliente.nomeEmpresa[0].toUpperCase() : '?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.accentPurple,
          ),
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