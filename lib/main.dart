import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rede_vizinha_app/bindings/home_binding.dart';
import 'package:rede_vizinha_app/controllers/auth_controller.dart';
import 'package:rede_vizinha_app/firebase_options.dart';
import 'package:rede_vizinha_app/routes.dart';
import 'package:rede_vizinha_app/theme/theme.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rede Vizinha',
      theme: AppTheme.darkTheme,
      initialBinding: HomeBinding(),
      initialRoute: '/',
      getPages: routes,
    );
  }
}
