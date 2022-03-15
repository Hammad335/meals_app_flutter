import 'package:flutter/material.dart';
import '../dummy_data.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item_details_screen';

  final Function toggleFavoritesCallBack;
  final Function isMealFavoriteCallBack;
  ItemDetailScreen(
      {required this.toggleFavoritesCallBack,
      required this.isMealFavoriteCallBack});

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        title: Text(
          selectMeal.title,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                letterSpacing: 1,
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleFavoritesCallBack(mealId);
        },
        backgroundColor: Theme.of(context).canvasColor,
        child: Icon(
          isMealFavoriteCallBack(mealId) ? Icons.star : Icons.star_border,
          color: Colors.green,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                child: Hero(
                  tag: selectMeal.id,
                  child: Image.network(
                    selectMeal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(
                        selectMeal.ingredients[index],
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
                itemCount: selectMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            '#${(index + 1)}',
                            style: const TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                        title: Text(
                          selectMeal.steps[index],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 50, right: 20),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: selectMeal.steps.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildContainer({required Widget child}) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(6),
        height: 200,
        width: 300,
        child: child);
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      padding: const EdgeInsets.only(left: 50),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
