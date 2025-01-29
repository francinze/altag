import 'package:altag/models/recipe.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:altag/providers/firestore_service.dart';

void main() {
  group('updateIngredient', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    final firestore = FakeFirebaseFirestore();
    final service = FirestoreService(firestore);

    setUp(() async {
      await firestore.collection('instructions').doc('test-id').set({});
    });

    tearDown(() async {
      await firestore.collection('instructions').doc('test-id').delete();
    });

    test('updates an existing ingredient list', () async {
      await firestore
          .collection('instructions')
          .doc('test-id')
          .collection('ingredients')
          .add({'name': 'test-list', 'options': []});

      final newOptionsList = [
        Ingredient(
          name: 'option1',
          description: 'option1',
          productUrl: 'option1',
        ),
        Ingredient(
          name: 'option2',
          description: 'option2',
          productUrl: 'option2',
        )
      ];
      await service.updateIngredient('test-id', 'test-list', newOptionsList);

      final updatedList = await firestore
          .collection('instructions')
          .doc('test-id')
          .collection('ingredients')
          .where('name', isEqualTo: 'test-list')
          .get();

      expect(updatedList.docs.first.data()['options'].length, 2);
    });

    test('adds a new ingredient list when it doesn\'t exist', () async {
      final newOptionsList = [
        Ingredient(
          name: 'test1',
          description: 'test1',
          productUrl: 'test1',
          imageUrl: 'test1',
        ),
        Ingredient(
          name: 'test2',
          description: 'test2',
          productUrl: 'test2',
          imageUrl: 'test2',
        ),
      ];
      await service.updateIngredient('test-id', 'new-list', newOptionsList);

      final newList = await firestore
          .collection('instructions')
          .doc('test-id')
          .collection('ingredients')
          .where('name', isEqualTo: 'new-list')
          .get();

      expect(newList.docs.first.data()['options'].length, 2);
    });

    test('updates an ingredient list with an empty options list', () async {
      await firestore
          .collection('instructions')
          .doc('test-id')
          .collection('ingredients')
          .add({'name': 'test-list', 'options': []});

      final newOptionsList = <Ingredient>[];
      await service.updateIngredient('test-id', 'test-list', newOptionsList);

      final updatedList = await firestore
          .collection('instructions')
          .doc('test-id')
          .collection('ingredients')
          .where('name', isEqualTo: 'test-list')
          .get();

      expect(updatedList.docs.first.data()['options'].length, 0);
    });

    test(
        'throws an error when updating an ingredient list with a null options list',
        () async {
      await firestore
          .collection('instructions')
          .doc('test-id')
          .collection('ingredients')
          .add({'name': 'test-list', 'options': []});

      expect(
        () => service.updateIngredient('test-id', 'test-list', null),
        throwsException,
      );
    });

    test('throws an error when updating an ingredient list with a null id',
        () async {
      expect(
        () => service.updateIngredient(null, 'test-list', []),
        throwsException,
      );
    });

    test(
        'throws an error when updating an ingredient list with a null listName',
        () async {
      expect(
          () => service.updateIngredient('test-id', null, []), throwsException);
    });
  });
}
