import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../pages/drawer_page.dart';

class AppDrawer extends StatelessWidget {
  final List<DrawerPage> screens;
  final Function(int) onTap;

  const AppDrawer({super.key, required this.screens, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('Configurações de Catálogo',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: List.generate(
                  screens.length,
                  (index) => _DrawerItem(
                    icon: screens[index].icon,
                    label: screens[index].title,
                    onTap: () {
                      Navigator.of(context).pop();

                      // ✅ adia o setState para depois do frame atual
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        onTap(screens[index].index);
                      });
                    },
                  ),
                ),
              ),
            ),
            const Spacer(),
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
