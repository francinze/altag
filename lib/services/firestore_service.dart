import 'package:altag/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/instruction.dart';

class FirestoreService {
  static Future<void> addUser(User user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({'name': user.displayName});
  }

  static Future<void> checkUser(String userName) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: userName)
        .get();
    assert(doc.docs.isNotEmpty);
  }

  static Stream<List<Instruction>> getInstructions() => FirebaseFirestore
      .instance
      .collection('instructions')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Instruction.fromFirestore(doc)).toList());

  static Future<void> addInstruction(
      Instruction i, Map<String, List<Ingredient>>? ingredients) async {
    final doc = await FirebaseFirestore.instance
        .collection('instructions')
        .add(i.toJson());
    if (i.category == 'recipe' && ingredients != null) {
      for (final ingredientOptions in ingredients.entries) {
        await FirebaseFirestore.instance
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

  static Future<void> deleteInstruction(String id) async =>
      await FirebaseFirestore.instance
          .collection('instructions')
          .doc(id)
          .delete();

  static Stream<Map<String, Instruction>> getInstructionsByCategory(
          String category) =>
      FirebaseFirestore.instance
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

  static Stream<Map<String, List<Ingredient>>> getIngredientsByRecipe(
          String recipeId) =>
      FirebaseFirestore.instance
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

  static Future<void> updateInstruction(Instruction i, String id,
      Map<String, List<Ingredient>>? ingredients) async {
    await FirebaseFirestore.instance
        .collection('instructions')
        .doc(id)
        .update(i.toJson());
    if (i.category == 'recipe' && ingredients != null) {
      for (final ingredientOptions in ingredients.entries) {
        await updateIngredient(
            id, ingredientOptions.key, ingredientOptions.value);
      }
    }
  }

  static Stream<List<Instruction>> searchInstructions(String query) =>
      FirebaseFirestore.instance
          .collection('instructions')
          .where('title', isGreaterThanOrEqualTo: query)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Instruction.fromFirestore(doc))
              .toList());

  static Future<void> updateIngredient(
      String id, String listName, List<Ingredient> newOptionsList) async {
    final list = await FirebaseFirestore.instance
        .collection('instructions')
        .doc(id)
        .collection('ingredients')
        .where('name', isEqualTo: listName)
        .get();
    if (list.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('instructions')
          .doc(id)
          .collection('ingredients')
          .add({
        'name': listName,
        'options': newOptionsList.map((i) => i.toJson()).toList(),
      });
    } else {
      list.docs.first.reference.update({
        'options': newOptionsList.map((i) => i.toJson()).toList(),
      });
    }
  }
}
