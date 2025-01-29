import 'package:altag/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:altag/pages/recipes/ingredient.dart';

void main() {
  group('IngredientPage', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    final ingredient = Ingredient(
        name: 'Test Ingredient',
        description: 'This is a test ingredient',
        productUrl: 'https://example.com');
    testWidgets('displays ingredient name, description, and link',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/ingredient': (context) => const IngredientPage(),
          },
          initialRoute: '/ingredient',
          onGenerateInitialRoutes: (initialRoute) {
            return [
              MaterialPageRoute(
                settings:
                    RouteSettings(name: '/ingredient', arguments: ingredient),
                builder: (context) => const IngredientPage(),
              ),
            ];
          },
        ),
      );
      expect(find.text('Test Ingredient'), findsOneWidget);
      expect(find.text('This is a test ingredient'), findsOneWidget);
      expect(find.text('LINK'), findsOneWidget);
    });

    testWidgets('displays image when image URL is provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/ingredient': (context) => const IngredientPage(),
          },
          initialRoute: '/ingredient',
          onGenerateInitialRoutes: (initialRoute) {
            return [
              MaterialPageRoute(
                settings: RouteSettings(
                    name: '/ingredient',
                    arguments: Ingredient(
                        name: 'Test Ingredient',
                        description: 'This is a test ingredient',
                        productUrl: 'https://example.com',
                        imageUrl: 'placeholder.png')),
                builder: (context) => const IngredientPage(),
              ),
            ];
          },
        ),
      );
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('does not display image when image URL is not provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/ingredient': (context) => const IngredientPage(),
          },
          initialRoute: '/ingredient',
          onGenerateInitialRoutes: (initialRoute) {
            return [
              MaterialPageRoute(
                settings:
                    RouteSettings(name: '/ingredient', arguments: ingredient),
                builder: (context) => const IngredientPage(),
              ),
            ];
          },
        ),
      );
      expect(find.byType(Image), findsNothing);
    });
  });
}
