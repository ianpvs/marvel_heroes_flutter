import 'package:flutter/material.dart';
import 'package:marvel_heroes/ui/theme/colors.dart';

class SearchFormHeroes extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchFormHeroes(
      {super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nome do Personagem',
              style: TextStyle(color: AppColors.primaryColor.color)),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Digite aqui o nome...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: onSearch,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.primaryColor.color, width: 2.0)),
            ),
            onSubmitted: (value) => onSearch(),
          ),
        ],
      ),
    );
  }
}
