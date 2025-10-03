import 'package:get/get.dart';
import 'package:rede_vizinha_app/modules/home/home_view.dart';
import 'package:rede_vizinha_app/modules/login/login_view.dart';
import 'package:rede_vizinha_app/modules/login/register_view.dart';
import 'package:rede_vizinha_app/modules/splash/splash_view.dart';

final routes = [
  GetPage(name: '/', page: () => const SplashView()),
  GetPage(name: '/login', page: () => const LoginView()),
  GetPage(name: '/register', page: () => const RegisterView()),
  GetPage(name: '/home', page: () => const HomeView()),
];
