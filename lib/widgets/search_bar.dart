import 'package:flutter/material.dart';
import '../theme/text_styles.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const SearchBar({
    super.key,
    required this.controller,
    this.hint = 'Pesquisar',
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppTextStyles.body1.copyWith(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.black),
        hintText: hint,
        hintStyle: AppTextStyles.body2.copyWith(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
