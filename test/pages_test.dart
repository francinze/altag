import 'package:flutter_test/flutter_test.dart';

import 'pages/recipes/ingredient.dart' as ingredient;
import 'pages/recipes/recipe.dart' as recipe;
import 'pages/recipes/recipes.dart' as recipes;
import 'pages/home.dart' as home;

void main() {
  group('Test recipe pages', () {
    ingredient.main();
    recipe.main();
    recipes.main();
  });
  group('Test pages', () {
    home.main();
  });
}
