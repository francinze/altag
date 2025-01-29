import 'package:altag/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:altag/models/recipe.dart';
import 'package:altag/sheets/add_ingredient_sheet.dart';

void main() {
  group('AddIngredientSheet', () {
    testWidgets('should display title field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AddIngredientSheet()),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('Title'), findsOneWidget);
    });

    testWidgets('should display description field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AddIngredientSheet()),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('Description'), findsOneWidget);
    });

    testWidgets('should display image field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AddIngredientSheet()),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('Image'), findsOneWidget);
    });

    testWidgets('should display URL field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AddIngredientSheet()),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('URL'), findsOneWidget);
    });

    testWidgets('should display save button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AddIngredientSheet()),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('should save ingredient when button is pressed',
        (tester) async {
      final ingredient = Ingredient(
        name: 'Test Ingredient',
        description: 'Test description',
        productUrl: 'https://example.com',
        imageUrl: 'https://example.com/image.jpg',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AddIngredientSheet(ingredient: ingredient)),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));

      // Verify that the ingredient is saved
      // You can use a mock or a test database to verify this
    });
  });
}
