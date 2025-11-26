import 'package:flutter/material.dart';
import 'package:lab1/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final Categoryy cat;

  const CategoryCard({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: cat);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.red.shade300, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    cat.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.broken_image, size: 40),
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                cat.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
