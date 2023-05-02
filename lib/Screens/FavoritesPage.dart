import 'package:flutter/material.dart';
import '../meal.dart';
import 'package:fimetlo/From_mimi/meal_item.dart';
import 'package:fimetlo/From_mimi/12.1 dummy_data.dart';

class FavoritesPage extends StatefulWidget {
  final darkMode;
  final List<Meal> favoriteMeals;
  FavoritesPage(this.favoriteMeals, this.darkMode);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMeals.isEmpty) {
      return Center(
        child: const Text("You have no favorites yet, start adding some!"),
      );
    } else {
      isFavorite = true;
    }

    if (isFavorite == true) {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: widget.favoriteMeals[index].id,
            title: widget.favoriteMeals[index].title,
            imageUrl: widget.favoriteMeals[index].imageUrl,
            duration: widget.favoriteMeals[index].duration,
            Price: widget.favoriteMeals[index].Price,
            rating: widget.favoriteMeals[index].rating,
            availability: widget.favoriteMeals[index].availability,
          );
        },
        itemCount: widget.favoriteMeals.length,
      );
    }

    throw (Exception e) {
      print(e);
    };
  }
}