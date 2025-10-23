import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/via_cores/edit/via_cores_form_view_model.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/custom_btn.dart';


import '../../../core/theme.dart';
import '../../../providers/via_cores_provider.dart';
import '../../../widgets/components/custom_text_input.dart';

class ViaCoresForm extends ConsumerStatefulWidget {
  final String? viacoresId;
  const ViaCoresForm({super.key, this.viacoresId});

  @override
  ConsumerState<ViaCoresForm> createState() => _ViaCoresFormState();
}

class _ViaCoresFormState extends ConsumerState<ViaCoresForm> {
  late final viewModel = ref.read(viaCoresViewModelProvider);

  @override
  void dispose() {
    viewModel.clear(); // Limpa os controllers
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.viacoresId != null) {
      _loadViaCores();
    }
  }

  Future<void> _loadViaCores() async {
    final notifierAsync = ref.read(viacoresProvider.notifier);
    final via = await notifierAsync.getById(widget.viacoresId!);
    if (via != null) {
      setState(() {
        viewModel.descricao.text = via.descricao;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final notifierAsync = ref.read(viacoresProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viacoresId != null ? 'Editar Via' : 'Cadastrar Via'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextInput(
                  controller: viewModel.descricao,
                  hintText: 'Nome da Via',
                  icon: Icons.business_center,
                  validator: (_) {
                    if (!viewModel.validar()) {
                      return viewModel.errorMessage;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomBtn(text: 'Salvar Alterações', onTap: () async {
                  if (viewModel.validar()) {
                    final viaCores = viewModel.getViaCores(id: widget.viacoresId);

                    if (widget.viacoresId != null) {
                      await notifierAsync.updateViaCores(viaCores);
                    } else {
                      await notifierAsync.add(viaCores);
                    }
                    viewModel.clear(); // limpa o controller
                    Navigator.pop(context);
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.accentPurple, AppColors.accentPink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentPurple.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => ViaCoresForm(),
          borderRadius: BorderRadius.circular(20),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
