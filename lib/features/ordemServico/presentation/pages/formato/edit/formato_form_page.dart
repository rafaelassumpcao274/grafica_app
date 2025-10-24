import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/custom_btn.dart';

import '../../../providers/formato_provider.dart';
import '../../../widgets/components/custom_text_input.dart';
import 'formato_form_view_model.dart';

class FormatoForm extends ConsumerStatefulWidget {
  final String? formatoId;

  const FormatoForm({super.key, this.formatoId});

  @override
  ConsumerState<FormatoForm> createState() => _FormatoFormState();
}

class _FormatoFormState extends ConsumerState<FormatoForm> {
  late final viewModel = ref.read(formatoViewModelProvider);

  @override
  void dispose() {
    viewModel.clear(); // Limpa os controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifierAsync = ref.read(formatoProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.formatoId != null ? 'Editar Formato' : 'Cadastrar Formato'),
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
                  hintText: 'Descrição: ',
                  icon: Icons.business_center,
                  validator: (_) {
                    if (!viewModel.validar()) {
                      return viewModel.errorMessage;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomBtn(
                    text: 'Salvar Alterações',
                    onTap: () async {
                      if (viewModel.validar()) {
                        final formato =
                            viewModel.getFormato(id: widget.formatoId);

                        if (widget.formatoId != null) {
                          await notifierAsync.updateFormato(formato);
                        } else {
                          await notifierAsync.addFormato(formato);
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
}
