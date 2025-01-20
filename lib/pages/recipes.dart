import 'package:altag/sheets/add_instruction_sheet.dart';
import 'package:flutter/material.dart';

import '../models/instruction.dart';
import '../services/firestore_service.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    return Scaffold(
      body: StreamBuilder<List<Instruction>>(
        stream: firestoreService.getInstructionsByCategory('recipes'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No instructions found.'));
          }
          final instructions = snapshot.data!;
          return ListView.builder(
            itemCount: instructions.length,
            itemBuilder: (context, index) {
              final instruction = instructions[index];
              return ListTile(
                title: Text(instruction.title),
                subtitle: Text(instruction.description),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final instruction = await showDialog(
              context: context,
              builder: (context) =>
                  const AddInstructionSheet(category: 'recipes'));
          if (instruction != null) {
            await firestoreService.addInstruction(instruction);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
