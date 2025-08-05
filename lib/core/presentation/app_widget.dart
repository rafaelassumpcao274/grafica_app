import 'package:flutter/material.dart';

import '../../features/ordemServico/presentation/pages/app_page.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unilith App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 35, 99, 235),),
        useMaterial3: true,
      ),
      home: const AppPage(),
    );
  }
}
