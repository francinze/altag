import 'package:altag/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/instruction.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Instruction>> getInstructions() {
    return _db.collection('instructions').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Instruction.fromFirestore(doc))
          .toList();
    });
  }

  Future<void> addInstruction(Instruction i) async =>
      await _db.collection('instructions').add(i.toJson());

  Future<void> deleteInstruction(String id) async {
    await _db.collection('instructions').doc(id).delete();
  }

  Stream<List<Instruction>> getInstructionsByCategory(String category) {
    return _db
        .collection('instructions')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        if (category == 'recipe') {
          return Recipe.fromFirestore(doc);
        }
        return Instruction.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> updateInstruction(
      String id, String title, String description) async {
    await _db.collection('instructions').doc(id).update({
      'title': title,
      'description': description,
    });
  }

  Stream<List<Instruction>> searchInstructions(String query) {
    return _db
        .collection('instructions')
        .where('title', isGreaterThanOrEqualTo: query)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Instruction.fromFirestore(doc))
          .toList();
    });
  }
}
