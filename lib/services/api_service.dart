import 'package:http/http.dart' as http;
import 'package:lab1/models/category_model.dart';
import 'package:lab1/models/mealDetail_model.dart';
import 'dart:convert';

import 'package:lab1/models/meal_model.dart';

class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/categories.php';

  Future<List<Categoryy>> loadCategories() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List categoriesJson = data['categories'];

      return categoriesJson
          .map((json) => Categoryy.fromJson(json))
          .toList();
    }else{
      throw Exception(
        'Failed to load categories. Status: ${response.statusCode}');
    }
  }

  Future<List<Meal>> loadMealsByCategory(Categoryy cat) async {
    final String url = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=${Uri.encodeComponent(cat.name)}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List mealsJson = data['meals'];

      return mealsJson
          .map((json) => Meal.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Failed to load meals for category ${cat.name}. Status: ${response.statusCode}');
    }
  }

  Future<Meal?> searchMealByName(String name) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=${name.toLowerCase()}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Meal.fromJson(data);
      }
      return null;
    }catch (e) {
      return null;
    }
  }

  Future<MealDetails?> getMealById(String id) async {
    final String url = 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List? mealsJson = data['meals'];

      if (mealsJson == null || mealsJson.isEmpty) return null;

      return MealDetails.fromJson(mealsJson[0]);
    } else {
      throw Exception('Failed to load meal by ID $id');
    }
  }

  Future<MealDetails?> getRandomMeal() async {
    final String url = 'https://www.themealdb.com/api/json/v1/1/random.php';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List? mealsJson = data['meals'];

      if (mealsJson == null || mealsJson.isEmpty) return null;

      return MealDetails.fromJson(mealsJson[0]);
    } else {
      throw Exception('Failed to load random meal. Status: ${response.statusCode}');
    }
  }
}