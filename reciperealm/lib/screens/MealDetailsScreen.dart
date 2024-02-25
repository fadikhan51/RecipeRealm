import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal, required this.onTapFav});

  final Meal meal;
  final Function(Meal meal) onTapFav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(onPressed: () {
            onTapFav(meal);
          }, icon: const Icon(Icons.star)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(10),
            child: Image.network(meal.imageUrl),
          ),
          const SizedBox(height: 10),
          Text(
            "Ingredients",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary, fontSize: 22),
          ),
          const SizedBox(
            height: 8,
          ),
          ...meal.ingredients.map((e) => Text(
                e,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              )),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Steps",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary, fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          ...meal.steps.map((e) => Text(
                e,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
