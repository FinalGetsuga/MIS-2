import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab1/models/meal_model.dart';
import 'package:lab1/widgets/meal_grid.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesBox = Hive.box<Meal>('favorites');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: ValueListenableBuilder(
        valueListenable: favoritesBox.listenable(),
        builder: (context, Box<Meal> box, _) {
          final meals = box.values.toList();

          if (meals.isEmpty) {
            return const Center(
              child: Text(
                "No favorite meals",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(12),
            child: MealGrid(meals: meals),
          );
        },
      ),
    );
  }
}
