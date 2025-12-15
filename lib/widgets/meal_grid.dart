import 'package:flutter/material.dart';
import 'package:lab1/models/meal_model.dart';
import 'package:lab1/widgets/meal_card.dart';

class MealGrid extends StatelessWidget {
  final List<Meal> meals;

  const MealGrid({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: meals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return MealCard(meal: meals[index]);
      },
    );
  }
}
