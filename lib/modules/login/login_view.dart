import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rede_vizinha_app/controllers/auth_controller.dart';
import 'package:rede_vizinha_app/modules/login/register_view.dart';
import 'package:rede_vizinha_app/theme/colors.dart';
import 'package:rede_vizinha_app/theme/text_styles.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/images/logo.svg', width: 150),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/images/bairro.svg', width: 120),
                ],
              ),
              const SizedBox(height: 8),
              Text('Login', style: AppTextStyles.headline1),
              const SizedBox(height: 20),

              // Email
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'E-mail',
                  style: AppTextStyles.body1.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(hint: 'email@email.com'),
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 18),

              // Senha
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Senha',
                  style: AppTextStyles.body1.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: _inputDecoration(hint: '******'),
                style: TextStyle(color: Colors.black),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(() => const RegisterView());
                    },
                    child: Text(
                      'Cadastre-se',
                      style: AppTextStyles.body1.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      /* esquecer senha flow */
                    },
                    child: Text(
                      'Esqueci minha senha',
                      style: AppTextStyles.body1.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Obx(() {
                if (auth.loading.value) {
                  return const CircularProgressIndicator(color: Colors.white);
                }
                return SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      final err = await auth.signIn(
                        email: emailCtrl.text.trim(),
                        password: passCtrl.text.trim(),
                      );
                      if (err != null) {
                        Get.snackbar(
                          'Erro',
                          err,
                          backgroundColor: Colors.white.withOpacity(0.9),
                        );
                      }
                    },
                    child: Text(
                      'Entrar',
                      style: AppTextStyles.body1.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
