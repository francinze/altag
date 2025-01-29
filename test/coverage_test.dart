import 'package:flutter_test/flutter_test.dart';
// ignore: unused_import
import 'package:altag/index.dart';

import 'firestore.dart' as firestore;
import 'pages.dart' as pages;

void main() {
  group('Test coverage', () {
    firestore.main();
    pages.main();
  });
}
