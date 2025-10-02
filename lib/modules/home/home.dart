import 'package:flutter/material.dart';
import 'package:rede_vizinha_app/theme/colors.dart';
import 'package:rede_vizinha_app/theme/text_styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rede Vizinha',
          style: AppTextStyles.headline1.copyWith(color: AppColors.textPrimary),
        ),
        backgroundColor: AppColors.primary,
        actions: [Padding(padding: EdgeInsets.all(24)), SearchBar()],
      ),
    );
  }
}
