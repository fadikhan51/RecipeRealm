import 'package:flutter/material.dart';
import 'package:reciperealm/screens/MealsScreen.dart';
import 'package:reciperealm/screens/category_screen.dart';

import '../models/meal.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int selectedTapButton = 0;
  List<Meal> favoriteMeals = [];
  late Widget activePage;

  @override
  void initState() {
    super.initState();
    activePage = CategoryScreen(
      onTapFav: _tapFavorite,
    );
  }

  void showInfoMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  void _tapFavorite(Meal meal) {
    final isExisting = favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        favoriteMeals = List.from(favoriteMeals)..remove(meal);
      });
      showInfoMessage("Recipe is no longer a favorite!");
    } else {
      setState(() {
        favoriteMeals = List.from(favoriteMeals)..add(meal);
      });
      showInfoMessage("Added to favorites");
    }
  }

  void _onTapChange(int index) {
    setState(() {
      selectedTapButton = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedTapButton == 1) {
      activePage = MealsScreen(
        category: "Favorites",
        meals: favoriteMeals,
        onTapFav: _tapFavorite,
      );
    } else {
      activePage = CategoryScreen(
        onTapFav: _tapFavorite,
      );
    }
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _onTapChange(index);
        },
        currentIndex: selectedTapButton,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
      body: activePage,
    );
  }
}
