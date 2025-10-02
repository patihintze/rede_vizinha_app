import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:rede_vizinha_app/widgets/search_bar.dart' as custom_widgets;
import '../controllers/home_controller.dart';
import '../widgets/category_card.dart';
import '../widgets/bottom_nav.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  final HomeController controller = Get.find<HomeController>();

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
                    const SizedBox(width: 40),
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

          // Conteúdo
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
                    onTap: () => controller.openCategory(c.id),
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
