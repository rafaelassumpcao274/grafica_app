import 'package:flutter/material.dart';

import '../../../domain/entities/enums/TipoServico.dart';
import '../../core/theme.dart';

class TipoServicoDropdown extends StatefulWidget {
  final TipoServico? valorInicial;
  final void Function(TipoServico?) onChanged;

  const TipoServicoDropdown({
    super.key,
    this.valorInicial,
    required this.onChanged,
  });

  @override
  State<TipoServicoDropdown> createState() => _TipoServicoDropdownState();
}

class _TipoServicoDropdownState extends State<TipoServicoDropdown> {
  TipoServico? _selecionado;

  @override
  void initState() {
    super.initState();
    _selecionado = widget.valorInicial;
  }

  @override
  void didUpdateWidget(covariant TipoServicoDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.valorInicial != oldWidget.valorInicial) {
      setState(() {
        _selecionado = widget.valorInicial;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mediumGray.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<TipoServico>(
        value: _selecionado,
        decoration: InputDecoration(
          hintText: 'Tipo de Serviço',
          hintStyle: TextStyle(color: AppColors.textGray, fontSize: 15),
          prefixIcon: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.accentPurple.withValues(alpha: 0.15),
                  AppColors.accentPink.withValues(alpha: 0.15)
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.business_outlined,
                color: AppColors.accentPurple, size: 20),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          suffixIcon: _selecionado != null
              ? IconButton(
                  icon: Icon(Icons.close, color: AppColors.textGray, size: 20),
                  onPressed: () => setState(() => _selecionado = null),
                )
              : null,
        ),
        items: TipoServico.values
            .map((tipoServico) => DropdownMenuItem(
                  value: tipoServico,
                  child: Text(tipoServico.label,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ))
            .toList(),
        onChanged: (TipoServico? novoValor) {
          setState(() {
            _selecionado = novoValor;
          });
          widget.onChanged(novoValor);
        },
        dropdownColor: AppColors.white,
        icon:
            Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textGray),
        isExpanded: true,
      ),
    );
  }
}
