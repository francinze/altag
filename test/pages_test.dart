import 'package:flutter_test/flutter_test.dart';

import 'pages/ingredient.dart' as ingredient;
import 'pages/recipe.dart' as recipe;

void main() {
  group('Test pages', () {
    ingredient.main();
    recipe.main();
  });
}
