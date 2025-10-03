import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rede_vizinha_app/modules/splash/splash_view.dart';
import 'theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rede Vizinha',
      theme: AppTheme.darkTheme,
      home: const SplashView(),
    );
  }
}
