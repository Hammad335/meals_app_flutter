// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/Category_items_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/item_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import '../screens/categories_screen.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green.shade200,
        canvasColor: const Color.fromRGBO(225, 224, 229, 0.9),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 24,
                color: Colors.black54,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
              headline2: const TextStyle(
                fontFamily: 'Raleway',
                fontSize: 26,
                color: Colors.white,
              ),
              headline3: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              caption: const TextStyle(
                fontSize: 20,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              subtitle1: const TextStyle(
                fontSize: 18,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
      ),
      // home: TabsScreen(),
      routes: {
        '/': (context) => TabsScreen(
            favoriteMeals: _favoriteMeals), // would replace home attribute
        CategoryItemsScreen.routeName: (context) =>
            CategoryItemsScreen(availableMeals: _availableMeals),
        ItemDetailScreen.routeName: (context) => ItemDetailScreen(
            toggleFavoritesCallBack: _toggleFavorites,
            isMealFavoriteCallBack: _isMealFavorite),
        FiltersScreen.routeName: (context) => FiltersScreen(
            currentFilters: _filters, setFiltersCallBack: _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  void _toggleFavorites(String mealId) {
    // indexWhere returns -1 if not found, otherwise the index of meal in list
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      // already in the favoritesList, so we have to remove that meal
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }
}
