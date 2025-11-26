import 'package:flutter/material.dart';
import 'package:lab1/models/category_model.dart';
import 'package:lab1/models/meal_model.dart';
import 'package:lab1/services/api_service.dart';
import 'package:lab1/widgets/meal_grid.dart';

class CategoryDetailsPage extends StatefulWidget {
  final Categoryy cat;

  const CategoryDetailsPage({super.key, required this.cat});

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  late final List<Meal> meals;
  List<Meal> filteredMeals = [];

  bool _loading = true;
  String _searchQuery = '';
  final ApiService _apiService = ApiService();

  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMealsList();
  }

  void _loadMealsList() async{
    final mealsList = await _apiService.loadMealsByCategory(widget.cat);
    setState(() {
      meals = mealsList;
      filteredMeals = mealsList;
      _loading = false;
    });
  }

  void _filterMeals(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        filteredMeals = meals;
      } else {
        filteredMeals = meals
            .where((meal) =>
            meal.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cat.name),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search meals by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _filterMeals(value);
              },
            ),
          ),
          Expanded(
            child: filteredMeals.isEmpty && _searchQuery.isNotEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No meal found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            )
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: MealGrid(meals: filteredMeals),
            ),
          ),
        ],
      ),

    );
  }
}
