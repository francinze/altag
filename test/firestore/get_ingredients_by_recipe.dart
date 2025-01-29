import 'package:altag/models/recipe.dart';
import 'package:altag/providers/firestore_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getIngredientsByRecipe', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    final firestore = FakeFirebaseFirestore();
    final service = FirestoreService(firestore);

    test('returns a Stream of Map with ingredients when recipe ID exists',
        () async {
      // Create a test recipe with ingredients
      const recipeId = 'test-recipe-id';
      await firestore
          .collection('instructions')
          .doc(recipeId)
          .collection('ingredients')
          .add({
        'name': 'Ingredient 1',
        'options': [
          {'name': 'Option 1', 'description': 'Description 1'},
          {'name': 'Option 2', 'description': 'Description 2'}
        ]
      });

      // Call the function
      final stream = service.getIngredientsByRecipe(recipeId);

      // Verify the result
      expect(stream, isA<Stream<Map<String, List<Ingredient>>>>());
      final ingredients = await stream.first;
      expect(ingredients, isA<Map<String, List<Ingredient>>>());
      expect(ingredients.length, 1);
      expect(ingredients['Ingredient 1']!.length, 2);
    });

    test('returns an empty Stream when recipe ID does not exist', () async {
      // Call the function with a non-existent recipe ID
      final stream = service.getIngredientsByRecipe('non-existent-recipe-id');

      // Verify the result
      expect(stream, isA<Stream<Map<String, List<Ingredient>>>>());
      final ingredients = await stream.first;
      expect(ingredients, isA<Map<String, List<Ingredient>>>());
      expect(ingredients.length, 0);
    });

    test('throws an error when recipe ID is null', () async {
      // Call the function with a null recipe ID
      expect(() => service.getIngredientsByRecipe(null), throwsException);
    });
  });
}
