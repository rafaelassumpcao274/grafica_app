import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../pages/drawer_page.dart';

class AppDrawer extends StatefulWidget {
  final List<DrawerPage> screens;
  final List<DrawerPage>? financialPages;
  final Function(int) onTap;

  const AppDrawer({
    super.key,
    required this.screens,
    required this.onTap,
    this.financialPages,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _expandFinancial = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('Menu',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  ...List.generate(
                    widget.screens.length - 1, // Remove a última seção (Financeiro placeholder)
                    (index) => _DrawerItem(
                      icon: widget.screens[index].icon,
                      label: widget.screens[index].title,
                      onTap: () {
                        Navigator.of(context).pop();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          widget.onTap(widget.screens[index].index);
                        });
                      },
                    ),
                  ),
                  // Seção Financeiro com submenu
                  if (widget.financialPages != null)
                    ExpansionTile(
                      leading: Icon(Icons.attach_money, color: AppColors.primaryBlue),
                      title: Text('Financeiro', style: Theme.of(context).textTheme.bodyLarge),
                      children: List.generate(
                        widget.financialPages!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: _DrawerItem(
                            icon: widget.financialPages![index].icon,
                            label: widget.financialPages![index].title,
                            onTap: () {
                              Navigator.of(context).pop();
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                widget.onTap(widget.financialPages![index].index);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('FieldCraft',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.textGray)),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryBlue),
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      onTap: onTap,
    );
  }
}
