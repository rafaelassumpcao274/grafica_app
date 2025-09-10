import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/provider/via_cores_view_model_provider.dart';
import '../../../providers/via_cores_provider.dart';
import '../../../widgets/components/custom_text_input.dart';

class ViaCoresForm extends ConsumerWidget {
  final String? viacoresId;
  const ViaCoresForm({super.key, this.viacoresId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(viaCoresViewModelProvider);
    final notifierAsync = ref.read(viacoresProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(viacoresId != null ? 'Editar Via' : 'Cadastrar Via'),
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
                if (viewModel.errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    viewModel.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xD818971C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      if (viewModel.validar()) {
                        final viaCores = viewModel.getViaCores(id: viacoresId);

                        if (viacoresId != null) {
                          await notifierAsync.updateViaCores(viaCores);
                        } else {
                          await notifierAsync.add(viaCores);
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      viacoresId != null ? 'Salvar Alterações' : 'Salvar',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
