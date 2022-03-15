import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/Category_items_screen.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryItem;

  CategoryItem({required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.of(context).pushNamed(
          CategoryItemsScreen.routeName,
          arguments: {
            'categoryItem': categoryItem,
          },
        )
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              categoryItem.color.withOpacity(0.7),
              categoryItem.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          categoryItem.title,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
