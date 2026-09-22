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
  String _lastFilter = '';


  // Carrega clientes do notifier
  Future<void> loadClientes() async {
    isLoading = true;
    notifyListeners();

    _clientes = [...?clienteNotifier.state.value ?? []];

    isLoading = false;
    notifyListeners();
  }

  // Filtra clientes por query. Ignora chamadas repetidas com o mesmo valor
  // para evitar disparar uma nova busca no banco a cada rebuild.
  Future<void> applyFilter(String query) async {
    if (query == _lastFilter) return;
    _lastFilter = query;

    if (query.isEmpty) {
      // Campo de busca limpo: restaura a lista completa.
      await clienteNotifier.loadClientes();
      await loadClientes();
      return;
    }

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
