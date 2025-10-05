import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/clientes.dart';
import '../../../providers/clientes_provider_refactored.dart';

final clientFormViewModelProvider = ChangeNotifierProvider.family<ClientFormViewModel, String?>((ref, clienteId) {
  final notifier = ref.watch(clientesNotifierProvider.notifier);
  final vm = ClientFormViewModel(notifier);
  if(clienteId != null && clienteId.isNotEmpty){
    vm.loadCliente(clienteId);
  }

  return vm;
});



class ClientFormViewModel extends ChangeNotifier {
  final ClientesNotifier clienteNotifier;

  ClientFormViewModel(this.clienteNotifier);

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  final telefoneController = TextEditingController();
  final enderecoController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();
  final cepController = TextEditingController();

  bool isLoading = false;

  // Carrega cliente existente
  Future<void> loadCliente(String clienteId) async {
    isLoading = true;
    notifyListeners();
    clearControllers();


      final cliente = await clienteNotifier.getClienteById(clienteId);
      if (cliente != null) {
        nameController.text = cliente.nomeEmpresa ?? '';
        emailController.text = cliente.email ?? '';
        cpfController.text = cliente.getDocumentFormatted() ?? '';
        telefoneController.text = cliente.telefone ?? '';
      }


    isLoading = false;
    notifyListeners();
  }

  void clearControllers() {

    nameController.clear();
    emailController.clear();
    cpfController.clear();
    telefoneController.clear();
    enderecoController.clear();
    cidadeController.clear();
    estadoController.clear();
    cepController.clear();
    notifyListeners();
  }


  // Salvar ou atualizar cliente
  Future<void> saveCliente(String? clienteId) async {
    final cliente = Clientes(
      id: clienteId,
      nomeEmpresa: nameController.text,
      email: emailController.text,
      documento: cpfController.text,
      telefone: telefoneController.text,
      contato: telefoneController.text,
    );

    if (clienteId != null) {
      await clienteNotifier.updateCliente(cliente);
    } else {
      await clienteNotifier.addCliente(cliente);
    }
  }
}
