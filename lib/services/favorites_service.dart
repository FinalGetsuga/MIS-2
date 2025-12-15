import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab1/models/meal_model.dart';

class FavoritesService {
  static final Box<Meal> _box = Hive.box<Meal>('favorites');

  static List<Meal> getFavorites() {
    return _box.values.toList();
  }

  static Future<void> addFavorite(Meal meal) async {
    if (!_box.values.any((m) => m.id == meal.id)) {
      await _box.add(meal);
    }
  }

  static Future<void> removeFavorite(String mealId) async {
    final key = _box.keys.firstWhere(
          (k) => _box.get(k)?.id == mealId,
      orElse: () => null,
    );
    if (key != null) await _box.delete(key);
  }

  static bool isFavorite(String mealId) {
    return _box.values.any((m) => m.id == mealId);
  }
}
