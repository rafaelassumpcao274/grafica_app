import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/clientes.dart';
import '../../../providers/clientes_provider_refactored.dart';

// Recebe um ClientesNotifier já carregado
final clientListViewModelProvider = ChangeNotifierProvider.family<ClientListViewModel, ClientesNotifier>(
      (ref, notifier) {
    return ClientListViewModel(notifier);
  },
);

class ClientListViewModel extends ChangeNotifier {
  final ClientesNotifier clienteNotifier;

  ClientListViewModel(this.clienteNotifier) : super() {
   loadClientes();
  }

  List<Clientes> _clientes = [];
  List<Clientes> get clientes => _clientes;

  bool isLoading = false;


  // Carrega clientes do notifier
  Future<void> loadClientes() async {
    isLoading = true;
    notifyListeners();

    _clientes = [...?clienteNotifier.state.value ?? []];

    isLoading = false;
    notifyListeners();
  }

  // Filtra clientes por query
  Future<void> applyFilter(String query) async {

    query = query.toLowerCase();
    await clienteNotifier.getClientesByNomeEmpresa(query);

    await loadClientes();
  }

  // Exclui cliente
  Future<void> deleteCliente(String? clienteId) async {
    if (clienteId == null) return;
    await clienteNotifier.deleteCliente(clienteId);
    await loadClientes();
    notifyListeners();
  }
}
