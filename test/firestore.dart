import 'package:flutter_test/flutter_test.dart';

import 'firestore/add_instruction.dart' as add_instruction;
import 'firestore/get_instructions.dart' as get_instructions;
import 'firestore/update_instruction.dart' as update_instruction;
import 'firestore/delete_instruction.dart' as delete_instruction;
import 'firestore/get_instructions_by_category.dart'
    as get_instructions_by_category;
import 'firestore/get_ingredients_by_recipe.dart' as get_ingredients_by_recipe;
import 'firestore/search_instructions.dart' as search_instructions;
import 'firestore/update_ingredient.dart' as update_ingredient;
import 'firestore/check_user.dart' as check_user;

void main() {
  group('FirestoreService', () {
    add_instruction.main();
    get_instructions.main();
    update_instruction.main();
    delete_instruction.main();
    get_instructions_by_category.main();
    get_ingredients_by_recipe.main();
    search_instructions.main();
    update_ingredient.main();
    check_user.main();
  });
}
