import 'package:hive/hive.dart';

part 'meal_model.g.dart';

@HiveType(typeId: 0)
class Meal extends HiveObject{
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String image;

  Meal({
    required this.name,
    required this.image,
    required this.id
  });

  Meal.fromJson(Map<String, dynamic> data)
      :name = data['strMeal'],
        image = data['strMealThumb'],
        id = data['idMeal'];

  Map<String, dynamic> toJson() => {
    'strMeal': name,
    'strMealThumb' : image,
    'idMeal' : id
  };
}