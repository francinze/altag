import 'package:flutter/material.dart';

import '../models/instruction.dart';

class AddInstructionSheet extends StatelessWidget {
  const AddInstructionSheet({required this.category, super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add Instruction'),
            const SizedBox(height: 8.0),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8.0),
            TextField(
              maxLines: 20,
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () => Navigator.pop(
                  context,
                  Instruction(
                    title: titleController.text,
                    description: descriptionController.text,
                    category: category,
                  )),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
