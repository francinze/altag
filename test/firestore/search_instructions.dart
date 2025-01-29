import 'package:altag/providers/firestore_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('searchInstructions', () {
    final service = FirestoreService();
    final firestore = FakeFirebaseFirestore();
    setUpAll(() => service.init(firestore));

    setUp(() async {
      await firestore.collection('instructions').doc('instruction1').set({
        'title': 'Instruction 1',
        'description': 'Description 1',
        'category': 'Category 1',
        'imageUrl': 'Image URL 1',
      });

      await firestore.collection('instructions').doc('instruction2').set({
        'title': 'Instruction 2',
        'description': 'Description 2',
        'category': 'Category 2',
        'imageUrl': 'Image URL 2',
      });

      await firestore.collection('instructions').doc('instruction3').set({
        'title': 'Instruction 3',
        'description': 'Description 3',
        'category': 'Category 3',
        'imageUrl': 'Image URL 3',
      });
    });

    tearDown(() async {
      await firestore.collection('instructions').get().then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    });

    test('searching with an empty query returns all instructions', () async {
      const query = '';
      final instructions = await service.searchInstructions(query).first;
      expect(instructions.length, 3);
    });

    test(
        'searching with a query that matches an instruction title returns the matching instruction',
        () async {
      const query = 'Instruction 1';
      final instructions = await service.searchInstructions(query).first;
      expect(instructions.length, 1);
      expect(instructions.first.title, 'Instruction 1');
    });

    test(
        'searching with a query that does not match any instruction titles returns an empty list',
        () async {
      const query = 'Non-existent instruction';
      final instructions = await service.searchInstructions(query).first;
      expect(instructions.length, 0);
    });

    test(
        'searching with a query that matches multiple instruction titles returns all matching instructions',
        () async {
      const query = 'Instruction';
      final instructions = await service.searchInstructions(query).first;
      expect(instructions.length, 3);
      expect(instructions.map((i) => i.title).toList(),
          ['Instruction 1', 'Instruction 2', 'Instruction 3']);
    });
  });
}
