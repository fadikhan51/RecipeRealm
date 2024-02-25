import 'package:flutter/material.dart';
import 'package:reciperealm/data/dummy_data.dart';
import 'package:reciperealm/widgets/mealItem.dart';

import '../models/category.dart';
import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  final String? category;
  final List<Meal> meals;
  final Function(Meal meal) onTapFav;

  MealsScreen({super.key, this.category, required this.meals, required this.onTapFav});

  @override
  Widget build(BuildContext context) {
    Widget activeContent = Center(
        child : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Uh Oh! Nothing Here",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Try selecting a different category",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),)
          ],
        ),
    );

    // print(meals.length);
    if(meals.isNotEmpty){
      activeContent = ListView.builder(itemCount: meals.length ,itemBuilder: (context, ind){
        return MealsItem(meal: meals[ind], onTapFav : onTapFav);
      });
    }
    if(category == null) {
      return activeContent;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category!),
      ),
      body: activeContent,
    );
  }
}
