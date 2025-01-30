import 'package:altag/generated/l10n.dart';
import 'package:altag/models/recipe.dart';
import 'package:altag/pages/recipes/recipe.dart';
import 'package:altag/sheets/add_instruction_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/instruction.dart';
import '../../providers/firestore_service.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final firestore = Provider.of<FirestoreService>(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.recipesTitle)),
      body: StreamBuilder<Map<String, Instruction>>(
        stream: firestore.getInstructionsByCategory('recipe'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(s.noRecipesMsg));
          }
          final instructions = snapshot.data!;
          return ListView.builder(
            itemCount: instructions.length,
            itemBuilder: (context, index) {
              final recipe = instructions.entries.elementAt(index);
              return ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  title: Text(recipe.value.title),
                  subtitle: Text(recipe.value.description,
                      maxLines: 3, overflow: TextOverflow.ellipsis),
                  trailing: recipe.value.imageUrl != null
                      ? Image.asset(
                          'assets/recipes/${recipe.value.imageUrl!}',
                          width: MediaQuery.of(context).size.width * 0.2,
                          fit: BoxFit.contain,
                        )
                      : null,
                  onTap: () => Navigator.pushNamed(context, '/recipe',
                      arguments: RecipePageArguments(
                          recipe.key, recipe.value as Recipe)));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final (instruction, ingredients) = await showModalBottomSheet(
              context: context,
              enableDrag: false,
              isScrollControlled: true,
              builder: (context) => AddInstructionSheet(
                  instruction: Instruction(
                      category: 'recipe', title: '', description: '')));
          if (instruction != null) {
            await firestore.addInstruction(instruction, ingredients);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
