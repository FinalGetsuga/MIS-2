class MealDetails {
  String id;
  String name;
  String image;
  String instructions;
  List<String> ingredients;
  String youtubeUrl;

  MealDetails({
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
    required this.ingredients,
    required this.youtubeUrl
  });

  factory MealDetails.fromJson(Map<String, dynamic> data){
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = data['strIngredient$i'];
      final measure = data['strMeasure$i'];
      if (ingredient != null &&
          ingredient.isNotEmpty &&
          ingredient != '' &&
          ingredient != ' ') {
        ingredients.add('$ingredient - $measure');
      }
    }

    return MealDetails(
      id: data['idMeal'],
      name: data['strMeal'],
      image: data['strMealThumb'],
      instructions: data['strInstructions'] ?? '',
      ingredients: ingredients,
      youtubeUrl: data['strYoutube'] ?? '',
    );
  }


  Map<String, dynamic> toJson() => {
    'idMeal': id,
    'strMeal' : name,
    'strMealThumb' : image,
    'strInstructions' : instructions,
    'ingredients' : ingredients,
    'strYoutube' : youtubeUrl
  };
}