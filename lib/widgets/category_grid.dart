import 'package:flutter/cupertino.dart';
import 'package:lab1/models/category_model.dart';
import 'package:lab1/widgets/category_card.dart';

class CategoryGrid extends StatefulWidget {
  final List<Categoryy> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  State<StatefulWidget> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 200/244),
        itemCount: widget.categories.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return CategoryCard(cat: widget.categories[index]);
        }
    );
  }
}