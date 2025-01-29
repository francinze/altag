import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:altag/providers/firestore_service.dart';

void main() {
  group('deleteInstruction', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    final service = FirestoreService();
    final firestore = FakeFirebaseFirestore();
    setUpAll(() async {
      service.init(firestore);
    });

    test('deletes an instruction with a valid ID', () async {
      final instructionId = await firestore
          .collection('instructions')
          .add({}).then((doc) => doc.id);
      await service.deleteInstruction(instructionId);
      final doc =
          await firestore.collection('instructions').doc(instructionId).get();
      expect(doc.exists, false);
    });

    test('throws an error when deleting an instruction with an invalid ID',
        () async {
      await expectLater(
          () async => await service.deleteInstruction('non-existent-id'),
          throwsException);
    });

    test('throws an error when deleting an instruction with a null ID',
        () async {
      await expectLater(
          () async => await service.deleteInstruction(null), throwsException);
    });
  });
}
