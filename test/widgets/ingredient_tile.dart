import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:altag/widgets/ingredient_tile.dart';
import 'package:altag/providers/auth.dart';
import 'package:altag/models/recipe.dart';

void main() {
  late MockFirebaseAuth service;
  late HouseAuthProvider auth;

  final ingredient = Ingredient(
      name: 'Test Ingredient',
      description: 'Test description',
      productUrl: 'https://example.com');

  setUp(() {
    service = MockFirebaseAuth();
    auth = HouseAuthProvider(service);
  });

  group('IngredientTile', () {
    testWidgets('displays ingredient name and description', (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<HouseAuthProvider>(
          create: (_) => auth,
          child: MaterialApp(
            home: Scaffold(
              body: IngredientTile(
                  i: MapEntry(0, ingredient), updateIngredient: (i) {}),
            ),
          ),
        ),
      );

      expect(find.text('Test Ingredient'), findsOneWidget);
      expect(find.text('Test description'), findsOneWidget);
    });

    testWidgets('shows edit button when hovered and user is authenticated',
        (tester) async {
      await service.signInAnonymously();

      await tester.pumpWidget(
        ChangeNotifierProvider<HouseAuthProvider>(
          create: (_) => auth,
          child: MaterialApp(
            home: Scaffold(
              body: IngredientTile(
                  i: MapEntry(0, ingredient), updateIngredient: (i) {}),
            ),
          ),
        ),
      );

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.byType(IngredientTile)));
      await tester.pumpAndSettle();

      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('hides edit button when not hovered and user is authenticated',
        (tester) async {
      await service.signInAnonymously();

      await tester.pumpWidget(
        ChangeNotifierProvider<HouseAuthProvider>(
          create: (_) => auth,
          child: MaterialApp(
            home: Scaffold(
              body: IngredientTile(
                  i: MapEntry(0, ingredient), updateIngredient: (i) {}),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(IconButton), findsNothing);
    });

    testWidgets('does not show edit button when user is not authenticated',
        (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<HouseAuthProvider>(
          create: (_) => auth,
          child: MaterialApp(
            home: Scaffold(
              body: IngredientTile(
                  i: MapEntry(0, ingredient), updateIngredient: (i) {}),
            ),
          ),
        ),
      );

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.byType(IngredientTile)));
      await tester.pumpAndSettle();

      expect(find.byType(IconButton), findsNothing);
    });
  });
}
