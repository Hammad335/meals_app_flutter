// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/widgets/category_item.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoryItemsScreen extends StatefulWidget {
  static const routeName = '/category_items_screen';
  final List<Meal> availableMeals;

  CategoryItemsScreen({required this.availableMeals});

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  late Category categoryItem;
  late List<Meal> categoryMeals;
  bool _loadedInitialData = false;

  @override
  void didChangeDependencies() {
    // this method is called after the widgets are initialized
    // getting specific category meals
    if (_loadedInitialData) {
      return;
    }
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, Category>;
    categoryItem = routeArgs['categoryItem']!;
    categoryMeals = widget.availableMeals.where((element) {
      return element.mealCategories.contains(categoryItem.id);
    }).toList();
    _loadedInitialData = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryItem.title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              complexity: categoryMeals[index].complexity,
              affordability: categoryMeals[index].affordability,
            );
          },
          itemCount: categoryMeals.length,
        ),
      ),
    );
  }
}
