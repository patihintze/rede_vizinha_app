import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'views/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rede Vizinha',
      theme: AppTheme.darkTheme,
      home: const HomeView(),
    );
  }
}
