import 'package:flutter_test/flutter_test.dart';

import 'pages/recipes/ingredient.dart' as ingredient;
import 'pages/recipes/recipe.dart' as recipe;
import 'pages/recipes/recipes.dart' as recipes;
import 'pages/home.dart' as home;

import 'sheets/add_ingredient.dart' as add_ingredient;
import 'sheets/add_instruction.dart' as add_instruction;

void main() {
  group('Test recipe pages', () {
    ingredient.main();
    recipe.main();
    recipes.main();
  });
  group('Test pages', () {
    home.main();
  });
  group('Test sheets', () {
    add_ingredient.main();
    add_instruction.main();
  });
}
