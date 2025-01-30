import 'package:altag/models/instruction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe extends Instruction {
  Recipe({
    required super.title,
    required super.description,
    super.imageUrl,
  }) : super(category: 'recipe');

  factory Recipe.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Recipe(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        imageUrl: data['imageUrl']);
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
