import 'package:altag/models/instruction.dart';
import 'package:altag/models/recipe.dart';
import 'package:altag/providers/firestore_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('addInstruction', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    final firestore = FakeFirebaseFirestore();
    final service = FirestoreService(firestore);

    tearDown(() async {
      // Clean up after all tests
      await firestore.collection('instructions').get().then((snapshot) async {
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });
    });

    tearDownAll(() async {
      // Clean up after all tests
      await firestore.collection('instructions').get().then((snapshot) async {
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });
    });

    test('adds an instruction without ingredients', () async {
      final instruction = Instruction(
          category: 'appliance',
          title: 'Test Instruction',
          description: 'Test Description');
      await service.addInstruction(instruction, null);
      final doc = await firestore.collection('instructions').get();
      expect(doc.docs.length, 1);
    });

    test('adds an instruction with ingredients', () async {
      final instruction = Instruction(
          category: 'recipe',
          title: 'Test Instruction',
          description: 'Test Description');
      final ingredients = {
        'ingredient1': [
          Ingredient(
              name: 'Ingredient 1',
              productUrl: 'https://example.com/ingredient1',
              imageUrl: 'https://example.com/ingredient1.jpg',
              description: 'Ingredient 1 description')
        ]
      };
      await service.addInstruction(instruction, ingredients);
      final doc = await firestore.collection('instructions').get();
      expect(doc.docs.length, 1);
      final ingredientDoc =
          await doc.docs.first.reference.collection('ingredients').get();
      expect(ingredientDoc.docs.length, 1);
    });

    test('adds an instruction with empty ingredients', () async {
      final instruction = Instruction(
          category: 'recipe',
          title: 'Test Instruction',
          description: 'Test Description');
      final ingredients = <String, List<Ingredient>>{};
      await service.addInstruction(instruction, ingredients);
      final doc = await firestore.collection('instructions').get();
      expect(doc.docs.length, 1);
      final ingredientDoc =
          await doc.docs.first.reference.collection('ingredients').get();
      expect(ingredientDoc.docs.length, 0);
    });

    test('adds an instruction with null ingredients', () async {
      final instruction = Instruction(
          category: 'recipe',
          title: 'Test Instruction',
          description: 'Test Description');
      await service.addInstruction(instruction, null);
      final doc = await firestore.collection('instructions').get();
      expect(doc.docs.length, 1);
      final ingredientDoc =
          await doc.docs.first.reference.collection('ingredients').get();
      expect(ingredientDoc.docs.length, 0);
    });

    test('handles error when adding an instruction fails', () async {
      expect(() async => service.addInstruction(null, null), throwsException);
    });
  });
}
