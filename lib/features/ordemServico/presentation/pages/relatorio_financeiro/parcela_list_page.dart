import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/parcela_provider.dart';

class ParcelaListPage extends ConsumerWidget {
  const ParcelaListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parcelaAsync = ref.watch(parcelaProvider);
    final parcelaNotifier = ref.read(parcelaProvider.notifier);

    return Scaffold(
      body: parcelaAsync.when(
        data: (parcelas) {
          if (parcelas.isEmpty) {
            return const Center(child: Text('Nenhuma parcela vencida'));
          }
          return ListView.builder(
            itemCount: parcelas.length,
            itemBuilder: (context, i) {
              final p = parcelas[i];
              return Card(
                child: ListTile(
                  title: Text('Parcela ${p.numero} - R\$ ${p.valor.toStringAsFixed(2)}'),
                  subtitle: Text('Vencimento: ${p.vencimento.toLocal().toIso8601String().split('T').first}'),
                  trailing: Text(p.status),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Erro: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await parcelaNotifier.loadVencidas();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
