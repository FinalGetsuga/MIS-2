import 'package:flutter/material.dart';
import 'package:lab1/models/meal_model.dart';
import 'package:lab1/services/favorites_service.dart';

class MealCard extends StatefulWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {

  void _toggleFavorite() async {
    // Check the current state from the service
    final isCurrentlyFavorite = FavoritesService.isFavorite(widget.meal.id);

    if (isCurrentlyFavorite) {
      // 1. Await the removal operation
      await FavoritesService.removeFavorite(widget.meal.id);
    } else {
      // 1. Await the addition operation
      await FavoritesService.addFavorite(widget.meal);
    }

    // 2. The local widget's build method relies on the service's state.
    // Calling setState() here forces the _MealCardState to rebuild,
    // which re-runs `FavoritesService.isFavorite(widget.meal.id)` in the build method
    // to get the *new* status.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = FavoritesService.isFavorite(widget.meal.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/mealDetails",
          arguments: widget.meal,
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
                widget.meal.image,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.meal.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: _toggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}
