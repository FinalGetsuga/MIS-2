import 'package:flutter/material.dart';
import 'package:lab1/models/meal_model.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/mealDetails",
          arguments: meal,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.red.shade300, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),

        clipBehavior: Clip.hardEdge,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 170,
              child: Image.network(
                meal.image,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                meal.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
