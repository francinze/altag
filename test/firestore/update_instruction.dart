import 'package:altag/models/instruction.dart';
import 'package:altag/models/recipe.dart';
import 'package:altag/providers/firestore_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('updateInstruction', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    final firestore = FakeFirebaseFirestore();
    final service = FirestoreService(firestore);

    test('updates an instruction with no ingredients', () async {
      // Arrange
      final instruction = Instruction(
        category: 'non-recipe',
        title: 'Test Instruction',
        description: 'Test Description',
      );
      const id = 'test-id';
      await firestore
          .collection('instructions')
          .doc(id)
          .set(instruction.toJson());

      // Act
      await service.updateInstruction(instruction, id, {});

      // Assert
      final updatedInstruction =
          await firestore.collection('instructions').doc(id).get();
      expect(updatedInstruction.data(), instruction.toJson());
    });

    test('updates an instruction with ingredients', () async {
      // Arrange
      final instruction = Instruction(
        category: 'recipe',
        title: 'Test Recipe',
        description: 'Test Description',
      );
      const id = 'test-id';
      await firestore
          .collection('instructions')
          .doc(id)
          .set(instruction.toJson());
      final ingredients = {
        'ingredient1': [
          Ingredient(
              name: 'Ingredient 1',
              description: 'Description 1',
              productUrl: 'https://example.com')
        ],
      };

      // Act
      await service.updateInstruction(instruction, id, ingredients);

      // Assert
      final updatedInstruction =
          await firestore.collection('instructions').doc(id).get();
      expect(updatedInstruction.data(), instruction.toJson());
      final ingredientDoc = await firestore
          .collection('instructions')
          .doc(id)
          .collection('ingredients')
          .where('name', isEqualTo: 'ingredient1')
          .get();
      expect(ingredientDoc.docs.length, 1);
    });

    test('updates an instruction with null ingredients', () async {
      // Arrange
      final instruction = Instruction(
        category: 'recipe',
        title: 'Test Recipe',
        description: 'Test Description',
      );
      const id = 'test-id';
      await firestore
          .collection('instructions')
          .doc(id)
          .set(instruction.toJson());

      // Act
      await service.updateInstruction(instruction, id, null);

      // Assert
      final updatedInstruction =
          await firestore.collection('instructions').doc(id).get();
      expect(updatedInstruction.data(), instruction.toJson());
    });

    test('throws an error when updating an instruction with a non-existent ID',
        () async {
      // Arrange
      final instruction = Instruction(
        category: 'non-recipe',
        title: 'Test Instruction',
        description: 'Test Description',
      );
      const id = 'non-existent-id';

      // Act and Assert
      expect(
        service.updateInstruction(instruction, id, {}),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
