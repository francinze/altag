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
    final FirestoreService firestoreService = FirestoreService();
    final s = S.of(context);
    return Scaffold(
      body: StreamBuilder<List<Instruction>>(
        stream: firestoreService.getInstructionsByCategory('recipe'),
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
              final instruction = instructions[index] as Recipe;
              return ListTile(
                  title: Text(instruction.title),
                  subtitle: Text(instruction.description),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipePage(
                          recipe: instruction,
                        ),
                      )));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final instruction = await showDialog(
              context: context,
              builder: (context) =>
                  const AddInstructionSheet(category: 'recipe'));
          if (instruction != null) {
            await firestoreService.addInstruction(instruction);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
