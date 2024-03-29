import 'package:flutter/material.dart';
import 'package:reciperealm/data/dummy_data.dart';
import 'package:reciperealm/screens/MealsScreen.dart';
import 'package:reciperealm/widgets/category_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoryScreen extends StatelessWidget {
  final Function(Meal meal) onTapFav;
  final List<Meal> filteredMeals;

  const CategoryScreen({super.key, required this.onTapFav, required this.filteredMeals});

  void _onSelectCategory(BuildContext ctx, Category category) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (BuildContext context) => MealsScreen(
            category: category.title,
            meals: filteredMeals
                .where((meal) => meal.categories.contains(category.id))
                .toList(),
            onTapFav: onTapFav),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        itemCount: availableCategories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (ctx, ind) {
          return CategoryItem(
            category: availableCategories[ind],
            onSelectCategory: () {
              _onSelectCategory(ctx, availableCategories[ind]);
            },
          );
        },
      ),
    );
  }
}
