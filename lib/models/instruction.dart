import 'package:cloud_firestore/cloud_firestore.dart';

class Instruction {
  final String title;
  final String description;
  final String category;
  final String? imageUrl;

  Instruction(
      {required this.title,
      required this.description,
      required this.category,
      this.imageUrl});

  factory Instruction.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Instruction(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}
