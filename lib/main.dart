import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rede_vizinha_app/bindings/home_binding.dart';
import 'package:rede_vizinha_app/firebase_options.dart';
import 'package:rede_vizinha_app/theme/theme.dart';
import 'package:rede_vizinha_app/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: const HomeView(),
    );
  }
}
