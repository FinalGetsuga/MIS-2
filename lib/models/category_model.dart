class Categoryy {
  String id;
  String name;
  String image;
  String desc;

  Categoryy({
    required this.id,
    required this.name,
    required this.image,
    required this.desc
  });

  Categoryy.fromJson(Map<String, dynamic> data)
    :id = data['idCategory'],
     name = data['strCategory'],
     image = data['strCategoryThumb'],
     desc = data['strCategoryDescription'];

  Map<String, dynamic> toJson() => {
    'idCategory': id,
    'strCategory' : name,
    'strCategoryThumb' : image,
    'strCategoryDescription' : desc
  };
}