import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fatura_provider.dart';

import '../../core/theme.dart';
import '../../widgets/components/custom_fab.dart';
import '../../widgets/fatura/fatura_card.dart';
import '../../widgets/fatura/fatura_parcelas_bottom_sheet.dart';
import 'fatura_creation_page.dart';

class FaturaListPage extends ConsumerWidget {
  const FaturaListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faturaAsync = ref.watch(faturaProvider);

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: faturaAsync.when(
        data: (faturas) {
          if (faturas.isEmpty) {
            return const Center(child: Text('Nenhuma fatura registrada'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: faturas.length,
            itemBuilder: (context, i) {
              final f = faturas[i];
              return FaturaCard(
                fatura: f,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (_) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: FaturaParcelasBottomSheet(
                        faturaId: f.id,
                        faturaLabel: f.clienteNome ?? 'Fatura #${f.id}',
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Erro: $error')),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FaturaCreationPage(),
            ),
          );
          ref.invalidate(faturaProvider);
        },
      ),
    );
  }
}
