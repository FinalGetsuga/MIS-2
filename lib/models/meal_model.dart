class Meal {
  String name;
  String image;
  String id;

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