import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/fornecedor/edit/fornecedor_form_page.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/papel/edit/papel_form_page.dart';

import '../widgets/cliente/cliente_filter_input.dart';
import '../widgets/components/custom_fab.dart';
import '../widgets/fornecedor/fornecedor_filter_input.dart';
import '../widgets/ordem_servico/ordem_servico_filter_input.dart';
import '../widgets/papel/papel_filter_input.dart';
import 'cliente/edit/client_form_page.dart';
import 'ordem_servico/edit/ordem_servico_form_page.dart';

class AppPage extends ConsumerStatefulWidget {
  const AppPage({super.key});

  @override
  ConsumerState<AppPage> createState() => _AppPageState();
}

class _AppPageState extends ConsumerState<AppPage>
    with SingleTickerProviderStateMixin {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.print),
            SizedBox(width: 8),
            Text('Unilith App'),
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
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 40, 53, 71)),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.note),
              title: const Text('Papel'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(title: const Text('Papeis')),
                      body: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: PapelFilterInput(),
                      ),
                      floatingActionButton: CustomFloatingActionButton(
                        icon: Icons.add,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PapelForm()),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 40, 53, 71),
          indicatorColor: const Color.fromARGB(255, 37, 100, 235),
          iconTheme:
              WidgetStateProperty.all(const IconThemeData(color: Colors.white)),
          labelTextStyle:
              WidgetStateProperty.all(const TextStyle(color: Colors.white)),
        ),
        child: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) =>
              setState(() => currentPageIndex = index),
          destinations: const [
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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [Expanded(child: OrdemServicoFilterInput())]),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [Expanded(child: ClientFilterInput())]),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [Expanded(child: FornecedorFilterInput())]),
        ),
      ][currentPageIndex],

      floatingActionButton: CustomFloatingActionButton(
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
          }
        },
        icon: Icons.add,
      ),
    );
  }
}
