import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/fornecedor/edit/fornecedor_form_page.dart';

import '../widgets/cliente/cliente_filter_input.dart';
import '../widgets/components/custom_fab.dart';
import '../widgets/fornecedor/fornecedor_filter_input.dart';
import '../widgets/ordem_servico/ordem_servico_filter_input.dart';
import 'cliente/edit/client_form_page.dart';
import 'ordem_servico/edit/ordem_servico_form_page.dart';

class AppPage extends ConsumerStatefulWidget {
  const AppPage({super.key});

  @override
  ConsumerState<AppPage> createState() => _AppPageState();
}

class _AppPageState extends ConsumerState<AppPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.print),
            const SizedBox(width: 8), // espaçamento entre ícone e texto
            const Text('Unilith app'),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor:
          Color.fromARGB(255, 40, 53, 71), 
               // cor de fundo azul
          indicatorColor: Color.fromARGB(255, 37, 100, 235),  // bolha de seleção
          iconTheme: WidgetStateProperty.all(
            const IconThemeData(color: Colors.white),
          ),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(color: Colors.white),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.description),
              icon: Icon(Icons.description_outlined),
              label: 'Ordem de Serviço',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.people),
              icon: Icon(Icons.people_outlined),
              label: 'Clientes',
            ),
            NavigationDestination(
              icon: Icon(Icons.business),
              label: 'Fornecedores',
            ),
          ],
        ),
      ),
      body: <Widget>[
        /// Home page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: OrdemServicoFilterInput()),
            ],
          ),
        ),

        /// Clientes page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: ClientFilterInput()),
            ],
          ),
        ),

        /// Fornecedor page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: FornecedorFilterInput()),
            ],
          ),
        ),

      ][currentPageIndex],
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          if (currentPageIndex == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrdemServicoForm()),
            );

          } else if (currentPageIndex == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClientForm()),
            );
          } else if (currentPageIndex == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FornecedorForm()),
            );
          }
        },
        icon: Icons.add,
      ),
    );
  }
}
