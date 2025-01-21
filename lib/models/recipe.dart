import 'package:altag/models/instruction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe extends Instruction {
  final Map<String, List<Ingredient>> ingredients;

  Recipe({
    required super.title,
    required super.description,
    required this.ingredients,
  }) : super(category: 'recipe');

  factory Recipe.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Recipe(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        ingredients: Map.fromEntries(
            List<MapEntry<String, List<Ingredient>>>.from(data['ingredients']
                .entries
                .map((l) => MapEntry(
                    l.key.toString(),
                    List<Ingredient>.from(
                        l.value.map((i) => Ingredient.fromFirestore(i))))))));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'ingredients': Map.fromEntries(ingredients.entries.map((entry) =>
          MapEntry(entry.key, entry.value.map((i) => i.toJson()).toList()))),
    };
  }
}

class Ingredient {
  final String name;
  final String description;
  final String productUrl;
  final String? imageUrl;

  Ingredient(
      {required this.name,
      required this.description,
      required this.productUrl,
      this.imageUrl});

  factory Ingredient.fromFirestore(data) {
    return Ingredient(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      productUrl: data['productUrl'] ?? '',
      imageUrl: data['imageUrl'],
    );
  }

  Map toJson() {
    return {
      'name': name,
      'description': description,
      'productUrl': productUrl,
      'imageUrl': imageUrl,
    };
  }
}
