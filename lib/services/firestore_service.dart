import 'package:altag/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/instruction.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(User user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({'email': user.email});
  }

  Stream<List<Instruction>> getInstructions() =>
      _db.collection('instructions').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Instruction.fromFirestore(doc)).toList());

  Future<void> addInstruction(
      Instruction i, Map<String, List<Ingredient>>? ingredients) async {
    final doc = await _db.collection('instructions').add(i.toJson());
    if (i.category == 'recipe' && ingredients != null) {
      for (final ingredientOptions in ingredients.entries) {
        await _db
            .collection('instructions')
            .doc(doc.id)
            .collection('ingredients')
            .add(
          {
            'name': ingredientOptions.key,
            'options': ingredientOptions.value.map((i) => i.toJson()).toList()
          },
        );
      }
    }
  }

  Future<void> deleteInstruction(String id) async =>
      await _db.collection('instructions').doc(id).delete();

  Stream<Map<String, Instruction>> getInstructionsByCategory(String category) =>
      _db
          .collection('instructions')
          .where('category', isEqualTo: category)
          .snapshots()
          .map((snapshot) {
        return Map.fromEntries(snapshot.docs.map((doc) {
          if (category == 'recipe') {
            return MapEntry(doc.id, Recipe.fromFirestore(doc));
          }
          return MapEntry(doc.id, Instruction.fromFirestore(doc));
        }));
      });

  Stream<Map<String, List<Ingredient>>> getIngredientsByRecipe(
          String recipeId) =>
      _db
          .collection('instructions')
          .doc(recipeId)
          .collection('ingredients')
          .snapshots()
          .map((snapshot) {
        return Map.fromEntries(snapshot.docs.map((doc) {
          final map = doc.data();
          return MapEntry(
              map['name'],
              (map['options'] as List)
                  .map((i) => Ingredient.fromFirestore(i))
                  .toList());
        }));
      });

  Future<void> updateInstruction(
          String id, String title, String description) async =>
      await _db.collection('instructions').doc(id).update({
        'title': title,
        'description': description,
      });

  Stream<List<Instruction>> searchInstructions(String query) => _db
      .collection('instructions')
      .where('title', isGreaterThanOrEqualTo: query)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Instruction.fromFirestore(doc)).toList());

  Future<void> updateIngredient(
          String id, String listName, List<Ingredient> newOptionsList) async =>
      await _db
          .collection('instructions')
          .doc(id)
          .collection('ingredients')
          .where('name', isEqualTo: listName)
          .get()
          .then((value) {
        final doc = value.docs.first;
        doc.reference.update({
          'options': newOptionsList.map((i) => i.toJson()).toList(),
        });
      });
}
