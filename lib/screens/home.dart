import 'package:flutter/material.dart';
import 'package:lab1/models/category_model.dart';
import 'package:lab1/services/api_service.dart';
import 'package:lab1/widgets/category_grid.dart';

import '../models/meal_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Categoryy>> _categoriesFuture;
  bool loadingRandom = false;

  void getRandomMeal() async {
    setState(() => loadingRandom = true);

    try {
      final randomMealDetails = await ApiService().getRandomMeal();

      if (randomMealDetails != null) {
        final meal = Meal(
          id: randomMealDetails.id,
          name: randomMealDetails.name,
          image: randomMealDetails.image,
        );

        Navigator.pushNamed(context, "/mealDetails", arguments: meal);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not load a random meal.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => loadingRandom = false);
    }
  }


  @override
  void initState() {
    super.initState();
    _categoriesFuture = ApiService().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          loadingRandom
              ? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ),
          )
              : IconButton(
            icon: const Icon(Icons.casino),
            tooltip: "Get Random Meal",
            onPressed: getRandomMeal,
          ),

          // Favorites button
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: "Favorites",
            onPressed: () {
              Navigator.pushNamed(context, "/favorites");
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Categoryy>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading categories:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No categories found'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CategoryGrid(categories: snapshot.data!),
            );
          }
        },
      ),
    );
  }
}
