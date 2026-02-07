import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/formato/edit/formato_form_page.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/fornecedor/edit/fornecedor_form_page.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/papel/edit/papel_form_page.dart';
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
    RelatorioScreen()
  ];



  @override
  Widget build(BuildContext context) {
    final List<DrawerPage> _screensDrawer = [
      DrawerPage(title: "Cores das vias", index: _screens.indexOf(ViaCoresFilterInput()), icon: Icons.palette_outlined),
      DrawerPage(title: "Papeis", index: 4, icon: Icons.layers_outlined),
      DrawerPage(title: "Formato", index: 5, icon: Icons.straighten_outlined),
      DrawerPage(title: "Relatório Financeiro", index: 6, icon: Icons.article),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if(currentPageIndex < 3)...[
              Icon(Icons.print),
              SizedBox(width: 8),
              Text('Unilith App'),
            ] else ...[
              Icon(_screensDrawer[currentPageIndex - 3].icon),
              SizedBox(width: 8),
              Text(_screensDrawer[currentPageIndex - 3].title),
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

      // 🔹 Drawer à direita com apenas Papel
      endDrawer: AppDrawer(
          screens: _screensDrawer,
          onTap: (index) => setState(() => currentPageIndex = index)),

      body: _screens[currentPageIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentPageIndex,
        onTap: (index) => setState(() => currentPageIndex = index),
      ),

      floatingActionButton: currentPageIndex != 6 ? CustomFloatingActionButton(
        onPressed: () {
          if (currentPageIndex == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const OrdemServicoForm()));
          } else if (currentPageIndex == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ClientForm()));
          } else if (currentPageIndex == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const FornecedorForm()));
          } else if (currentPageIndex == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ViaCoresForm()));
          } else if (currentPageIndex == 4) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const PapelForm()));
          } else if (currentPageIndex == 5) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const FormatoForm()));
          }
        },
        icon: Icons.add,
      ): null,
    );
  }
}
