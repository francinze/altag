import 'package:altag/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webauthn/webauthn.dart';

import '../models/instruction.dart';

class FirestoreService extends ChangeNotifier {
  late FirebaseFirestore _firestore;

  void init(FirebaseFirestore instance) {
    _firestore = instance;
    if (_firestore.runtimeType != FakeFirebaseFirestore) {
      _firestore.settings = const Settings(persistenceEnabled: false);
    }
    notifyListeners();
  }

  Future<void> checkUser(String? userName) async {
    if (userName == null) {
      throw InvalidArgumentException('userName cannot be null');
    }
    final doc = await _firestore
        .collection('users')
        .where('name', isEqualTo: userName)
        .get();
    assert(doc.docs.isNotEmpty);
  }

  Stream<List<Instruction>> getInstructions() =>
      _firestore.collection('instructions').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Instruction.fromFirestore(doc)).toList());

  Future<void> addInstruction(
      Instruction? i, Map<String, List<Ingredient>>? ingredients) async {
    if (i == null) {
      throw InvalidArgumentException('i cannot be null');
    }
    final doc = await _firestore.collection('instructions').add(i.toJson());
    if (i.category == 'recipe' && ingredients != null) {
      for (final ingredientOptions in ingredients.entries) {
        await _firestore
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

  Future<void> deleteInstruction(String? id) async {
    if (id == null) {
      throw InvalidArgumentException('id cannot be null');
    }
    final doc = await _firestore.collection('instructions').doc(id).get();
    if (!doc.exists) {
      throw InvalidArgumentException('Instruction with id $id does not exist');
    }
    await _firestore.collection('instructions').doc(id).delete();
  }

  Stream<Map<String, Instruction>> getInstructionsByCategory(String? category) {
    if (category == null) {
      throw InvalidArgumentException('category cannot be null');
    }
    return _firestore
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
  }

  Stream<Map<String, List<Ingredient>>> getIngredientsByRecipe(
      String? recipeId) {
    if (recipeId == null) {
      throw InvalidArgumentException('recipeId cannot be null');
    }
    return _firestore
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
  }

  Future<void> updateInstruction(Instruction i, String id,
      Map<String, List<Ingredient>>? ingredients) async {
    final doc = await _firestore.collection('instructions').doc(id).get();
    if (!doc.exists) {
      throw AssertionError('Instruction with id $id does not exist');
    }
    await _firestore.collection('instructions').doc(id).update(i.toJson());
    if (i.category == 'recipe' && ingredients != null) {
      for (final ingredientOptions in ingredients.entries) {
        await updateIngredient(
            id, ingredientOptions.key, ingredientOptions.value);
      }
    }
  }

  Stream<List<Instruction>> searchInstructions(String query) => _firestore
      .collection('instructions')
      .where('title', isGreaterThanOrEqualTo: query)
      .where('title', isLessThan: '${query}z')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Instruction.fromFirestore(doc)).toList());

  Future<void> updateIngredient(
      String? id, String? listName, List<Ingredient>? newOptionsList) async {
    if (id == null) {
      throw InvalidArgumentException('id cannot be null');
    } else if (listName == null) {
      throw InvalidArgumentException('listName cannot be null');
    } else if (newOptionsList == null) {
      throw InvalidArgumentException('newOptionsList cannot be null');
    }
    final list = await _firestore
        .collection('instructions')
        .doc(id)
        .collection('ingredients')
        .where('name', isEqualTo: listName)
        .get();
    if (list.docs.isEmpty) {
      await _firestore
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
