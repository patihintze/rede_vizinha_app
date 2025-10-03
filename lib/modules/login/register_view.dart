import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rede_vizinha_app/controllers/auth_controller.dart';
import 'package:rede_vizinha_app/theme/colors.dart';
import 'package:rede_vizinha_app/theme/text_styles.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final auth = Get.find<AuthController>();

  final nameCtrl = TextEditingController();
  final birthCtrl = TextEditingController();
  final cpfCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final cepCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primary, AppColors.background],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    const Spacer(),
                    Text(
                      'Cadastre-se',
                      style: AppTextStyles.headline1.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildField(
                      'Nome completo',
                      nameCtrl,
                      validator:
                          (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Informe o nome'
                                  : null,
                    ),
                    _buildField(
                      'Data de nascimento (DD/MM/AAAA)',
                      birthCtrl,
                      validator:
                          (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Informe a data'
                                  : null,
                    ),
                    _buildField(
                      'CPF',
                      cpfCtrl,
                      validator:
                          (v) =>
                              (v == null || v.isEmpty) ? 'Informe o CPF' : null,
                      keyboard: TextInputType.number,
                    ),
                    _buildField(
                      'E-mail',
                      emailCtrl,
                      validator:
                          (v) =>
                              (v == null || !v.contains('@'))
                                  ? 'E-mail inválido'
                                  : null,
                      keyboard: TextInputType.emailAddress,
                    ),
                    _buildField(
                      'Telefone',
                      phoneCtrl,
                      validator:
                          (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Informe o telefone'
                                  : null,
                      keyboard: TextInputType.phone,
                    ),
                    _buildField(
                      'CEP',
                      cepCtrl,
                      validator:
                          (v) =>
                              (v == null || v.length < 8)
                                  ? 'Informe o CEP'
                                  : null,
                      keyboard: TextInputType.number,
                    ),
                    _buildField(
                      'Senha',
                      passCtrl,
                      validator:
                          (v) =>
                              (v == null || v.length < 6)
                                  ? 'Senha muito curta'
                                  : null,
                      obscure: true,
                    ),
                    const SizedBox(height: 18),
                    Obx(() {
                      if (auth.loading.value) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;
                          final err = await auth.signUp(
                            name: nameCtrl.text.trim(),
                            birthDate: birthCtrl.text.trim(),
                            cpf: cpfCtrl.text.trim(),
                            email: emailCtrl.text.trim(),
                            phone: phoneCtrl.text.trim(),
                            cep: cepCtrl.text.trim(),
                            password: passCtrl.text.trim(),
                          );
                          if (err != null) {
                            Get.snackbar(
                              'Erro',
                              err,
                              backgroundColor: Colors.white,
                              colorText: Colors.black,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 14,
                          ),
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Cadastrar',
                          style: AppTextStyles.body1.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController ctrl, {
    String? Function(String?)? validator,
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.body1.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: ctrl,
            validator: validator,
            keyboardType: keyboard,
            obscureText: obscure,
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(60, 125, 123, 123),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
