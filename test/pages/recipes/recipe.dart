// test/pages/recipes/recipe_test.dart
import 'package:altag/generated/l10n.dart';
import 'package:altag/models/recipe.dart';
import 'package:altag/widgets/ingredient_tile.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:altag/pages/recipes/recipe.dart';
import 'package:altag/providers/firestore_service.dart';
import 'package:altag/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  group('RecipePage', () {
    late FakeFirebaseFirestore firestore;
    late MockFirebaseAuth auth;
    late FirestoreService service;
    late HouseAuthProvider authService;
    late String recipeId;
    late Recipe recipe;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      firestore = FakeFirebaseFirestore();
      auth = MockFirebaseAuth();
      service = FirestoreService(firestore);
      authService = HouseAuthProvider(auth);
      recipe = Recipe(title: 'Test Recipe', description: 'Test Description');
      final ingr = <String, List<Ingredient>>{
        'Ingredient 1': [
          Ingredient(
              name: 'Option 1',
              description: 'Option 1 Description',
              productUrl: 'https://example.com'),
          Ingredient(
              name: 'Option 2',
              description: 'Option 2 Description',
              productUrl: 'https://example.com')
        ]
      };
      await service.addInstruction(recipe, ingr);
      recipeId = await firestore
          .collection('instructions')
          .where('title', isEqualTo: 'Test Recipe')
          .get()
          .then((snapshot) => snapshot.docs.first.id);
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
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => authService),
            ChangeNotifierProvider(create: (_) => service),
          ],
          child: MaterialApp(
            routes: {'/recipe': (context) => const RecipePage()},
            initialRoute: '/recipe',
            onGenerateInitialRoutes: (initialRoute) {
              return [
                MaterialPageRoute(
                  settings: RouteSettings(
                      name: '/recipe',
                      arguments: RecipePageArguments(recipeId, recipe)),
                  builder: (context) => const RecipePage(),
                ),
              ];
            },
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Displays all relevant information',
        (WidgetTester tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => authService),
          ChangeNotifierProvider(create: (_) => service),
        ],
        child: MaterialApp(
          routes: {'/recipe': (context) => const RecipePage()},
          initialRoute: '/recipe',
          onGenerateInitialRoutes: (initialRoute) {
            return [
              MaterialPageRoute(
                settings: RouteSettings(
                    name: '/recipe',
                    arguments: RecipePageArguments(recipeId, recipe)),
                builder: (context) => const RecipePage(),
              ),
            ];
          },
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Test Recipe'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.byType(IngredientTile), findsWidgets);
    });

    testWidgets(
        'IconButton opens AddInstructionSheet and returns updated recipe',
        (tester) async {
      await auth.signInAnonymously();
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => authService),
          ChangeNotifierProvider(create: (_) => service),
        ],
        child: MaterialApp(
          routes: {'/recipe': (context) => const RecipePage()},
          initialRoute: '/recipe',
          localizationsDelegates: const [S.delegate],
          onGenerateInitialRoutes: (initialRoute) {
            return [
              MaterialPageRoute(
                settings: RouteSettings(
                    name: '/recipe',
                    arguments: RecipePageArguments(recipeId, recipe)),
                builder: (context) => const RecipePage(),
              ),
            ];
          },
        ),
      ));

      await tester.pumpAndSettle();
      // Find the IconButton
      final iconButton = find.byType(IconButton);

      // Tap the IconButton
      await tester.tap(iconButton);
      await tester.pumpAndSettle();
      // Verify that the AddInstructionSheet is opened
      expect(find.textContaining('Add '), findsWidgets);

      // Fill in the fields
      await tester.enterText(find.byType(TextField).first, 'New Title');
      await tester.enterText(find.byType(TextField).at(1), 'New Description');

      // Close with arguments
      await tester.tap(find.byType(ElevatedButton).last);

      // Verify that the AddInstructionSheet is closed
      expect(find.textContaining('New Title'), findsWidgets);

      // Verify that the instruction was updated
      final updatedInstruction =
          await firestore.collection('instructions').doc(recipeId).get();
      expect(updatedInstruction.data(), {
        'title': 'New Title',
        'description': 'New Description',
        'category': 'recipe',
        'imageUrl': null
      });
    });
  });
}
