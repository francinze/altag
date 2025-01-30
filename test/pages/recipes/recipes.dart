// test/pages/recipes/recipes_test.dart
import 'package:altag/generated/l10n.dart';
import 'package:altag/models/recipe.dart';
import 'package:altag/pages/recipes/recipe.dart';
import 'package:altag/providers/auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:altag/pages/recipes/recipes.dart';
import 'package:altag/providers/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  group('RecipesPage', () {
    late FakeFirebaseFirestore firestore;
    late MockFirebaseAuth auth;
    late FirestoreService service;
    late HouseAuthProvider authService;

    setUp(() {
      firestore = FakeFirebaseFirestore();
      service = FirestoreService(firestore);
      auth = MockFirebaseAuth();
      authService = HouseAuthProvider(auth);
    });

    tearDownAll(() async {
      await firestore.collection('instructions').get().then((snapshot) async {
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });
    });

    testWidgets('displays loading indicator when data is being fetched',
        (WidgetTester tester) async {
      // Arrange
      await service.addInstruction(
          Recipe(description: 'Test Description', title: 'Test Recipe'), {});

      // Act
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => service),
          ],
          child: const MaterialApp(
            home: RecipesPage(),
            localizationsDelegates: [S.delegate],
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays recipes list', (WidgetTester tester) async {
      // Arrange
      await service.addInstruction(
        Recipe(description: 'Test Description', title: 'Test Recipe'),
        {},
      );

      // Act
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => service),
          ],
          child: const MaterialApp(
            home: RecipesPage(),
            localizationsDelegates: [S.delegate],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('navigates to recipe page when recipe is tapped',
        (WidgetTester tester) async {
      // Arrange
      await service.addInstruction(
        Recipe(description: 'Test Description', title: 'Test Recipe'),
        {},
      );
      // Act
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => authService),
            ChangeNotifierProvider(create: (_) => service),
          ],
          child: MaterialApp(
            routes: {
              '/recipe': (_) => const RecipePage(),
            },
            home: const RecipesPage(),
            localizationsDelegates: const [S.delegate],
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(RecipePage), findsOneWidget);
    });
  });
}
