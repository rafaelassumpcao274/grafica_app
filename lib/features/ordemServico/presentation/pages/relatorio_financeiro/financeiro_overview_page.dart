import 'package:flutter/material.dart';
import 'fatura_list_page.dart';
import 'parcela_list_page.dart';
import 'relatorio_financeiro.dart';

class FinanceiroOverviewPage extends StatelessWidget {
  const FinanceiroOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Financeiro')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Faturas'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FaturaListPage())),
          ),
          ListTile(
            leading: const Icon(Icons.payments),
            title: const Text('Parcelas vencidas'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ParcelaListPage())),
          ),
          ListTile(
            leading: const Icon(Icons.insert_chart),
            title: const Text('Relatório mensal'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RelatorioScreen())),
          ),
        ],
      ),
    );
  }
}
