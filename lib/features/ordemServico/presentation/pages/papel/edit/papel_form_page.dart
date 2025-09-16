import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/papel/edit/papel_form_view_model.dart';


import '../../../widgets/components/custom_text_input.dart';
import '../../../widgets/number_editing_controller.dart';

class PapelForm extends ConsumerStatefulWidget {
  final String? papelId;
  const PapelForm({super.key, this.papelId});

  @override
  ConsumerState<PapelForm> createState() => _PapelFormState();
}

class _PapelFormState extends ConsumerState<PapelForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadPapelIfEditing();
  }

  Future<void> _loadPapelIfEditing() async {
    if (widget.papelId != null) {
      final viewModel = ref.read(papelFormViewModelProvider);
      await viewModel.loadPapel(widget.papelId!);
    } else {
      ref.read(papelFormViewModelProvider).clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(papelFormViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.papelId != null ? 'Editar Papel' : 'Cadastrar Papel'),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextInput(
                  controller: viewModel.descricao,
                  hintText: 'Nome do Papel',
                  icon: Icons.business_center,
                  validator: (_) => viewModel.errorMessage,
                ),
                const SizedBox(height: 16.0),
                CustomTextInput(
                  controller: viewModel.quantidade,
                  hintText: 'Quantidade de Folhas',
                  icon: Icons.numbers,
                ),
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
                      if (_formKey.currentState!.validate() && viewModel.validar()) {
                        final papel = viewModel.getPapel(id: widget.papelId);

                        if (widget.papelId != null) {
                          await viewModel.notifier.updatePapel(papel);
                        } else {
                          await viewModel.notifier.add(papel);
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      widget.papelId != null ? 'Salvar Alterações' : 'Salvar',
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
