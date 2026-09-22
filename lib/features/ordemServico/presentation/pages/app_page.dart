import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/formato/edit/formato_form_page.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/fornecedor/edit/fornecedor_form_page.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/papel/edit/papel_form_page.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/relatorio_financeiro/fatura_list_page.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/relatorio_financeiro/parcela_list_page.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/relatorio_financeiro/relatorio_financeiro.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/via_cores/edit/via_cores_form_page.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/title_page.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/via_cores/via_cores_filter_input.dart';

import '../widgets/app_drawer.dart';
import '../widgets/cliente/cliente_filter_input.dart';
import '../widgets/components/custom_bottom_nav.dart';
import '../widgets/components/custom_fab.dart';
import '../widgets/formato/formato_filter_input.dart';
import '../widgets/fornecedor/fornecedor_filter_input.dart';
import '../widgets/ordem_servico/ordem_servico_filter_input.dart';
import '../widgets/papel/papel_filter_input.dart';
import 'cliente/edit/client_form_page.dart';
import 'drawer_page.dart';
import 'ordem_servico/edit/ordem_servico_form_page.dart';

enum AppPageSection {
  ordemServico(0, 'Ordem de Serviço', Icons.description_outlined),
  cliente(1, 'Clientes', Icons.people_outline),
  fornecedor(2, 'Fornecedores', Icons.business_outlined),
  viacores(3, 'Cores das Vias', Icons.palette_outlined),
  papel(4, 'Papéis', Icons.layers_outlined),
  formato(5, 'Formato', Icons.straighten_outlined),
  faturas(7, 'Faturas', Icons.receipt_long),
  parcelas(8, 'Parcelas Vencidas', Icons.payments),
  relatorio(9, 'Relatório Financeiro', Icons.insert_chart);

  final int i;
  final String title;
  final IconData icon;

  const AppPageSection(this.i, this.title, this.icon);
}

class PageMetadata {
  final AppPageSection section;
  final Widget screen;
  final bool isBottomNavItem;

  PageMetadata({
    required this.section,
    required this.screen,
    this.isBottomNavItem = false,
  });
}

class AppPage extends ConsumerStatefulWidget {
  const AppPage({super.key});

  @override
  ConsumerState<AppPage> createState() => _AppPageState();
}

class _AppPageState extends ConsumerState<AppPage>
    with SingleTickerProviderStateMixin {
  int currentPageIndex = 0;

  final List<Widget> _screens = [
    OrdemServicoFilterInput(),
    ClientFilterInput(),
    FornecedorFilterInput(),
    ViaCoresFilterInput(),
    PapelFilterInput(),
    FormatoFilterInput(),
  ];



  @override
  Widget build(BuildContext context) {
    final List<DrawerPage> _screensDrawer = [
      DrawerPage(title: "Cores das vias", index: 3, icon: Icons.palette_outlined),
      DrawerPage(title: "Papéis", index: 4, icon: Icons.layers_outlined),
      DrawerPage(title: "Formato", index: 5, icon: Icons.straighten_outlined),
      DrawerPage(title: 'Financeiro', index: -1, icon: Icons.attach_money),
    ];

    final List<DrawerPage> _financialPages = [
      DrawerPage(title: 'Faturas', index: 7, icon: Icons.receipt_long),
      DrawerPage(title: 'Parcelas Vencidas', index: 8, icon: Icons.payments),
      DrawerPage(title: 'Relatório Mensal', index: 9, icon: Icons.insert_chart),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if(currentPageIndex < 3)...[
              Icon(Icons.print),
              SizedBox(width: 8),
              Text('Unilith App'),
            ] else if(currentPageIndex >= 3 && currentPageIndex < 7)...[
              Icon(_screensDrawer[currentPageIndex - 3].icon),
              SizedBox(width: 8),
              Text(_screensDrawer[currentPageIndex - 3].title),
            ] else if(currentPageIndex >= 7)...[
              Icon(Icons.attach_money),
              SizedBox(width: 8),
              Text(_financialPages[currentPageIndex - 7].title),
            ] else ...[
              Icon(Icons.print),
              SizedBox(width: 8),
              Text('Unilith App'),
            ]
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),

      endDrawer: AppDrawer(
          screens: _screensDrawer,
          financialPages: _financialPages,
          onTap: (index) => setState(() => currentPageIndex = index)),

      body: _getBodyScreen(),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentPageIndex,
        onTap: (index) => setState(() => currentPageIndex = index),
      ),

      floatingActionButton: currentPageIndex < 7 && currentPageIndex != 6 ? CustomFloatingActionButton(
        onPressed: _handleFABPress,
        icon: Icons.add,
      ): null,
    );
  }

  Widget _getBodyScreen() {
    if (currentPageIndex < _screens.length) {
      return _screens[currentPageIndex];
    } else if (currentPageIndex == 7) {
      return const FaturaListPage();
    } else if (currentPageIndex == 8) {
      return const ParcelaListPage();
    } else if (currentPageIndex == 9) {
      return const RelatorioScreen();
    }
    return const SizedBox.shrink();
  }

  void _handleFABPress() {
    final Map<int, VoidCallback> routes = {
      0: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrdemServicoForm())),
      1: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClientForm())),
      2: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FornecedorForm())),
      3: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ViaCoresForm())),
      4: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PapelForm())),
      5: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FormatoForm())),
    };
    routes[currentPageIndex]?.call();
  }
}
