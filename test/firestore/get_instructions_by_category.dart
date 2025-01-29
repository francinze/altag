import 'package:altag/models/instruction.dart';
import 'package:altag/models/recipe.dart';
import 'package:altag/providers/firestore_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getInstructionsByCategory', () {
    final service = FirestoreService();
    final firestore = FakeFirebaseFirestore();
    setUpAll(() async {
      service.init(firestore);
    });

    tearDownAll(() async {
      // Clean up after all tests
      await firestore.collection('instructions').get().then((snapshot) async {
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });
    });

    test('returns a stream of recipes when category is recipe', () async {
      // Arrange
      final recipe = Recipe(
        title: 'Test Recipe',
        description: 'Test Description',
      );
      await firestore.collection('instructions').add(recipe.toJson());

      // Act
      final stream = service.getInstructionsByCategory('recipe');
      final instructions = await stream.first;

      // Assert
      expect(instructions.length, 1);
      expect(instructions.values.first, isA<Recipe>());
    });

    test('returns a stream of instructions when category is not recipe',
        () async {
      // Arrange
      final instruction = Instruction(
        title: 'Test Instruction',
        description: 'Test Description',
        category: 'appliance',
      );
      await firestore.collection('instructions').add(instruction.toJson());

      // Act
      final stream = service.getInstructionsByCategory('appliance');
      final instructions = await stream.first;

      // Assert
      expect(instructions.length, 1);
      expect(instructions.values.first, isA<Instruction>());
    });

    test(
        'returns an empty stream when there are no instructions in the category',
        () async {
      // Act
      final stream = service.getInstructionsByCategory('non-existent-category');
      final instructions = await stream.first;

      // Assert
      expect(instructions.length, 0);
    });

    test('throws an error when category is null', () async {
      // Act and Assert
      expect(() => service.getInstructionsByCategory(null), throwsException);
    });
  });
}
