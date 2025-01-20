import 'package:altag/models/instruction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe extends Instruction {
  final String title;
  final String description;
  final List<Ingredient> ingredients;

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
  }) : super(title: title, description: description, category: 'recipes');

  factory Recipe.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Recipe(
      title: data['title'],
      description: data['description'],
      ingredients: (data['ingredients'] as List)
          .map((i) => Ingredient.fromFirestore(i))
          .toList(),
    );
  }
}

class Ingredient {
  final String name;
  final String description;
  final String? imageUrl;

  Ingredient({required this.name, required this.description, this.imageUrl});

  factory Ingredient.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Ingredient(
      name: data['name'],
      description: data['description'],
      imageUrl: data['imageUrl'],
    );
  }
}
