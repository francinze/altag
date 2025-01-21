import 'package:altag/models/recipe.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class AddIngredientSheet extends StatelessWidget {
  const AddIngredientSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final imageController = TextEditingController();
    final urlController = TextEditingController();
    final s = S.of(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.of(context).addIngredient),
          const SizedBox(height: 8.0),
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: s.ingrTitleLabel),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: s.ingrDescriptionLabel),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: urlController,
            decoration: InputDecoration(labelText: s.ingrURLLabel),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: imageController,
            decoration: InputDecoration(labelText: s.ingrImageLabel),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () => Navigator.pop(
                context,
                Ingredient(
                  name: titleController.text,
                  description: descriptionController.text,
                  productUrl: urlController.text,
                  imageUrl: imageController.text,
                )),
            child: Text(S.of(context).saveInstruction),
          )
        ],
      ),
    );
  }
}
