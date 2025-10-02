import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import '../models/category.dart';

class HomeController extends GetxController {
  final List<Category> categories =
      [
        Category(id: '1', title: 'Meus vizinhos', icon: Icons.people_outline),
        Category(id: '2', title: 'Coleta de lixo', icon: Icons.delete_outline),
        Category(id: '3', title: 'Segurança', icon: Icons.videocam_outlined),
        Category(id: '4', title: 'Anúncios', icon: Icons.campaign_outlined),
        Category(id: '5', title: 'Mapa do bairro', icon: Icons.place_outlined),
        Category(id: '6', title: 'Dicas', icon: Icons.lightbulb_outline),
        Category(id: '7', title: 'Notícias', icon: Icons.article_outlined),
        Category(id: '8', title: 'Tempo', icon: Icons.wb_sunny_outlined),
      ].obs;

  final selectedIndex = 0.obs;

  void selectIndex(int i) => selectedIndex.value = i;

  void openCategory(String id) {
    debugPrint('Abrindo categoria: $id');
  }
}
