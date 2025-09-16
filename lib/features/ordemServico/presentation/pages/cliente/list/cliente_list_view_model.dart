import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/clientes.dart';
import '../../../providers/clientes_provider_refactored.dart';

// Recebe um ClientesNotifier já carregado
final clientListViewModelProvider = ChangeNotifierProvider.family<ClientListViewModel, ClientesNotifier>(
      (ref, notifier) {
    final vm = ClientListViewModel(notifier);
    vm.loadClientes();
    return vm;
  },
);

class ClientListViewModel extends ChangeNotifier {
  final ClientesNotifier clienteNotifier;

  ClientListViewModel(this.clienteNotifier);

  List<Clientes> _clientes = [];
  List<Clientes> get clientes => _clientes;

  bool isLoading = false;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Carrega clientes do notifier
  Future<void> loadClientes() async {
    isLoading = true;
    notifyListeners();

    _clientes = clienteNotifier.state;
    isLoading = false;
    notifyListeners();
  }

  // Filtra clientes por query
  List<Clientes> get filteredClientes {
    if (_searchQuery.isEmpty) return _clientes;

    final query = _searchQuery.toLowerCase();
    return _clientes.where((c) {
      return (c.nomeEmpresa.toLowerCase().contains(query)) ||
          (c.documento.toLowerCase().contains(query)) ||
          (c.email?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  // Atualiza a query do filtro
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Exclui cliente
  Future<void> deleteCliente(String? clienteId) async {
    if (clienteId == null) return;
    await clienteNotifier.deleteCliente(clienteId);
    _clientes = clienteNotifier.state;
    notifyListeners();
  }
}
