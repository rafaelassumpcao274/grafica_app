import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/enums/TipoServico.dart';
import '../../../../domain/entities/fornecedor.dart';
import '../../../providers/fornecedor_provider.dart';


// Provider para o form, recebe o Notifier
final fornecedorFormViewModelProvider =
ChangeNotifierProvider.family<FornecedorFormViewModel, String?>(
      (ref, fornecedorId) {
    final notifier = ref.watch(fornecedorNotifierProvider.notifier);
    final vm = FornecedorFormViewModel(notifier);

    if (fornecedorId != null) {
      vm.loadFornecedor(fornecedorId);
    }

    return vm;
  },
);



class FornecedorFormViewModel extends ChangeNotifier {
  final FornecedorNotifier notifier;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contatoController = TextEditingController();
  final telefoneController = TextEditingController();
  final observacaoController = TextEditingController();
  TipoServico? tipoSelecionado;

  bool isLoading = false;

  FornecedorFormViewModel(this.notifier);

  void clearFields() {
    nameController.clear();
    emailController.clear();
    contatoController.clear();
    telefoneController.clear();
    observacaoController.clear();
    tipoSelecionado = null;
    notifyListeners();
  }

  Future<void> loadFornecedor(String? fornecedorId) async {
    isLoading = true;
    notifyListeners();

    if (fornecedorId == null) {
      clearFields(); // Novo fornecedor → limpa campos
    } else {
      final fornecedor = await notifier.getById(fornecedorId);
      if (fornecedor != null) {
        nameController.text = fornecedor.nome ?? '';
        emailController.text = fornecedor.email ?? '';
        contatoController.text = fornecedor.contato ?? '';
        telefoneController.text = fornecedor.telefone ?? '';
        observacaoController.text = fornecedor.observacao ?? '';
        tipoSelecionado = fornecedor.tipoServico;
      }
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> saveFornecedor(String? fornecedorId) async {
    final fornecedor = Fornecedor(
      id: fornecedorId,
      nome: nameController.text,
      email: emailController.text,
      contato: contatoController.text,
      telefone: telefoneController.text,
      observacao: observacaoController.text,
      tipoServico: tipoSelecionado ?? TipoServico.distribuidora,
    );

    if (fornecedorId != null) {
      await notifier.updateFornecedor(fornecedor);
    } else {
      await notifier.addFornecedor(fornecedor);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    contatoController.dispose();
    telefoneController.dispose();
    observacaoController.dispose();
    super.dispose();
  }
}

