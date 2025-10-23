

import 'package:flutter/material.dart';

class DrawerPage  {
  final int index;
  final String title;
  final IconData icon;

  const DrawerPage({ String? title, required this.index, IconData? icon })
      : title = title != null ? title : 'Unilith App', icon = icon != null ? icon: Icons.person;

}
