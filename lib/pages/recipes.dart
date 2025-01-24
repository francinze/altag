import 'package:altag/generated/l10n.dart';
import 'package:altag/models/recipe.dart';
import 'package:altag/pages/recipe.dart';
import 'package:altag/sheets/add_instruction_sheet.dart';
import 'package:flutter/material.dart';

import '../models/instruction.dart';
import '../services/firestore_service.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      body: StreamBuilder<Map<String, Instruction>>(
        stream: FirestoreService.getInstructionsByCategory('recipe'),
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
                  title: Text(recipe.value.title),
                  subtitle: Text(recipe.value.description),
                  trailing: recipe.value.imageUrl != null
                      ? Image.asset(recipe.value.imageUrl!)
                      : null,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipePage(
                          id: recipe.key,
                          recipe: recipe.value as Recipe,
                        ),
                      )));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final (instruction, ingredients) = await showDialog(
              context: context,
              builder: (context) => AddInstructionSheet(
                  instruction: Instruction(
                      category: 'recipe', title: '', description: '')));
          if (instruction != null) {
            await FirestoreService.addInstruction(instruction, ingredients);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
