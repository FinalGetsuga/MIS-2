import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lab1/models/category_model.dart';
import 'package:lab1/models/meal_model.dart';
import 'package:lab1/screens/category_details_page.dart';
import 'package:lab1/screens/favorites_page.dart';
import 'package:lab1/screens/home.dart';
import 'package:lab1/screens/meal_details_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(MealAdapter());
  await Hive.openBox<Meal>('favorites');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Categories",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent)
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const MyHomePage(title: 'Categories'),
        '/details': (context) {
          final cat = ModalRoute.of(context)!.settings.arguments as Categoryy;
          return CategoryDetailsPage(cat: cat);
        },

        "/mealDetails": (context) {
          final meal = ModalRoute.of(context)!.settings.arguments as Meal;
          return MealDetailsPage(meal: meal);
        },
        "/favorites": (context) => const FavoritesPage()
      },
    );
  }
}

