import 'package:altag/providers/firestore_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getInstructions', () {
    final service = FirestoreService();
    final firestore = FakeFirebaseFirestore();
    setUpAll(() => service.init(firestore));

    setUp(() async {
      await firestore.collection('instructions').get().then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    });

    tearDown(() async {
      await firestore.collection('instructions').get().then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    });

    test(
        'returns a stream of instructions when the Firestore collection is not empty',
        () async {
      await firestore.collection('instructions').add({
        'title': 'Instruction 1',
        'description': 'Description 1',
        'category': 'Category 1',
        'imageUrl': 'Image URL 1',
      });

      final instructions = await service.getInstructions().first;
      expect(instructions.length, 1);
      expect(instructions.first.title, 'Instruction 1');
    });

    test('returns an empty stream when the Firestore collection is empty',
        () async {
      final instructions = await service.getInstructions().first;
      expect(instructions.length, 0);
    });
  });
}
