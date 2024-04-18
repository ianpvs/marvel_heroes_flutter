import 'package:flutter/material.dart';
import 'package:marvel_heroes/domain/entities/hero.dart';
import 'package:marvel_heroes/ui/theme/colors.dart';

class ListHeroesListView extends StatelessWidget {
  final List<HeroEntity> heroes;

  const ListHeroesListView({super.key, required this.heroes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: heroes.length,
      itemBuilder: (context, index) {
        final hero = heroes[index];
        return Container(
          decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: AppColors.primaryColor.color, width: 2)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(hero.thumbnailPath,
                    width: 70, height: 70, fit: BoxFit.contain),
              ),
              const SizedBox(width: 10),
              Text(hero.name)
            ],
          ),
        );
      },
    );
  }
}
