import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rede_vizinha_app/controllers/neighbors_controller.dart';
import 'package:rede_vizinha_app/models/user_model.dart';
import 'package:rede_vizinha_app/theme/colors.dart';
import 'package:rede_vizinha_app/theme/text_styles.dart';
import 'package:rede_vizinha_app/widgets/neighbor_card.dart';
import 'package:rede_vizinha_app/widgets/search_bar.dart' as custom_widgets;

class NeighborsView extends StatefulWidget {
  const NeighborsView({super.key});
  @override
  State<NeighborsView> createState() => _NeighborsViewState();
}

class _NeighborsViewState extends State<NeighborsView> {
  final NeighborsController controller = Get.put(NeighborsController());
  final TextEditingController _searchController = TextEditingController();
  String query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text('Meus vizinhos'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 8),
              custom_widgets.SearchBar(controller: _searchController),
            ],
          ),
          Expanded(
            child: StreamBuilder<List<UserModel>>(
              stream: controller.usersStream,
              builder: (context, snap) {
                if (snap.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar vizinhos',
                      style: AppTextStyles.body1,
                    ),
                  );
                }
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final list = controller.filterByName(snap.data!, query);
                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 56,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Nenhum vizinho encontrado',
                          style: AppTextStyles.body1.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    // apenas reavalia o stream; Firestore snapshots são em tempo real
                    // para forçar refresh, você poderia re-query, mas aqui apenas espera um tick
                    await Future.delayed(const Duration(milliseconds: 300));
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final user = list[index];
                      return NeighborCard(
                        user: user,
                        onTap: () {
                          // exemplo: abrir detalhes do usuário
                          Get.toNamed('/neighbor_detail', arguments: user.uid);
                        },
                        onLongPress: () {
                          // ação opcional: copiar e-mail, abrir contato, etc.
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
