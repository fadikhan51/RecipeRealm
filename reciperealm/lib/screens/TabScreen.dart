import 'package:flutter/material.dart';
import 'package:reciperealm/data/dummy_data.dart';
import 'package:reciperealm/main.dart';
import 'package:reciperealm/screens/MealsScreen.dart';
import 'package:reciperealm/screens/category_screen.dart';
import 'package:reciperealm/widgets/MainDrawer.dart';

import '../models/meal.dart';
import 'FiltersScreen.dart';

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
  String activePageTitle = 'Select your Category';
  Map<Filter, bool> filtersApplied = initialMapState;
  List<Meal> filteredMeals = dummyMeals;

  @override
  void initState() {
    super.initState();
    activePage = CategoryScreen(
      onTapFav: _tapFavorite,
      filteredMeals: filteredMeals,
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

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(filterApplied: filtersApplied,),
        ),
      );
      setState(() {
        filtersApplied = result ?? initialMapState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    filteredMeals = dummyMeals.where((meal){
      if(!meal.isGlutenFree && filtersApplied[Filter.glutenFree]!) {
        return false;
      }
      if(!meal.isLactoseFree && filtersApplied[Filter.lactoseFree]!) {
        return false;
      }
      if(!meal.isVegetarian && filtersApplied[Filter.vegetarian]!) {
        return false;
      }
      if(!meal.isVegan && filtersApplied[Filter.vegan]!) {
        return false;
      }
      return true;
    }).toList();

    if (selectedTapButton == 1) {
      activePageTitle = "Favorites";
      activePage = MealsScreen(
        meals: favoriteMeals,
        onTapFav: _tapFavorite,
      );
    } else {
      activePageTitle = "Select your Category";
      activePage = CategoryScreen(
        onTapFav: _tapFavorite,
        filteredMeals: filteredMeals,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
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
      drawer: MainDrawer(setScreen: _setScreen,),
      body: activePage,
    );
  }
}
