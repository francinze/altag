import 'package:cloud_firestore/cloud_firestore.dart';

class Instruction {
  final String title;
  final String description;
  final String category;

  Instruction(
      {required this.title, required this.description, required this.category});

  factory Instruction.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Instruction(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
    );
  }
}
