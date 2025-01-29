import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:altag/providers/firestore_service.dart';

void main() {
  group('FirestoreService', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    final service = FirestoreService();
    final firestore = FakeFirebaseFirestore();
    setUpAll(() async {
      service.init(firestore);
    });

    test('checkUser throws an error when the user is not found', () async {
      // Arrange
      const userName = 'non-existent-user';

      // Act and Assert
      expect(() => service.checkUser(userName), throwsAssertionError);
    });

    test('checkUser does not throw an error when the user is found', () async {
      // Arrange
      await firestore
          .collection('users')
          .doc('test-uid')
          .set({'name': 'Test User'});

      // Act and Assert
      await service.checkUser('Test User');
    });

    test('checkUser throws an error when the input userName is null', () async {
      // Act and Assert
      expect(() => service.checkUser(null), throwsException);
    });
  });
}
