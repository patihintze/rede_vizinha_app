// lib/views/home_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rede_vizinha_app/controllers/auth_controller.dart'; // 1. Adicione este import
import 'package:rede_vizinha_app/widgets/search_bar.dart' as custom_widgets;
import '../../controllers/home_controller.dart';
import '../../widgets/category_card.dart';
import '../../widgets/bottom_nav.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  final HomeController controller = Get.find<HomeController>();
  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        authController.signOut();
                      },
                      tooltip: 'Sair',
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    Text('Rede Vizinha', style: AppTextStyles.headline1),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mark_email_unread_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                custom_widgets.SearchBar(controller: _searchController),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              return GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                itemCount: controller.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 18,
                  childAspectRatio: 1.6,
                ),
                itemBuilder: (context, index) {
                  final c = controller.categories[index];
                  return CategoryCard(
                    icon: c.icon,
                    label: c.title,
                    onTap: () {
                      if (c.id == '1') {
                        Get.toNamed('/neighbors');
                        return;
                      }
                      if (c.id == '2') {
                        Get.toNamed('/coleta');
                        return;
                      }
                      if (c.id == '3') {
                        Get.snackbar(
                          'Em breve',
                          'Área em construção',
                          backgroundColor: Colors.white.withOpacity(0.9),
                          colorText: Colors.black,
                        );
                      }
                      if (c.id == '4') {
                        Get.snackbar(
                          'Em breve',
                          'Área em construção',
                          backgroundColor: Colors.white.withOpacity(0.9),
                          colorText: Colors.black,
                        );
                      }
                      if (c.id == '5') {
                        Get.snackbar(
                          'Em breve',
                          'Área em construção',
                          backgroundColor: Colors.white.withOpacity(0.9),
                          colorText: Colors.black,
                        );
                      }
                      if (c.id == '6') {
                        Get.snackbar(
                          'Em breve',
                          'Área em construção',
                          backgroundColor: Colors.white.withOpacity(0.9),
                          colorText: Colors.black,
                        );
                      }
                      if (c.id == '7') {
                        Get.snackbar(
                          'Em breve',
                          'Área em construção',
                          backgroundColor: Colors.white.withOpacity(0.9),
                          colorText: Colors.black,
                        );
                      }
                      if (c.id == '8') {
                        Get.snackbar(
                          'Em breve',
                          'Área em construção',
                          backgroundColor: Colors.white.withOpacity(0.9),
                          colorText: Colors.black,
                        );
                      }
                      controller.openCategory(c.id);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),

      bottomNavigationBar: Obx(
        () => CustomBottomNav(
          currentIndex: controller.selectedIndex.value,
          onTap: (i) => controller.selectIndex(i),
        ),
      ),
    );
  }
}
