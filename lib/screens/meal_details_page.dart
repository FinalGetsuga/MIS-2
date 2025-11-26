import 'package:flutter/material.dart';
import 'package:lab1/models/mealDetail_model.dart';
import 'package:lab1/models/meal_model.dart';
import 'package:lab1/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailsPage extends StatefulWidget {
  final Meal meal;

  const MealDetailsPage({super.key, required this.meal});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  MealDetails? details;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    final info = await ApiService().getMealById(widget.meal.id);
    setState(() {
      details = info;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.name),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : details == null
          ? const Center(child: Text("Failed to load meal details."))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(details!.image),
            ),

            const SizedBox(height: 16),

            Text(
              details!.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Ingredients:",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ...details!.ingredients.map(
                  (e) => Text("• $e",
                  style: const TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 20),

            const Text(
              "Instructions:",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(details!.instructions,
                style: const TextStyle(fontSize: 16, height: 1.3)),

            const SizedBox(height: 20),

            if (details!.youtubeUrl != null && details!.youtubeUrl.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "YouTube:",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async{
                      final url = Uri.parse(details!.youtubeUrl);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Could not open link")),
                        );
                      }
                    },
                    child: Text(
                      details!.youtubeUrl,
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
