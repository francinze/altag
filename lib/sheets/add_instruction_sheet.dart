import 'package:altag/models/recipe.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../models/instruction.dart';
import 'add_ingredient_sheet.dart';

class AddInstructionSheet extends StatefulWidget {
  const AddInstructionSheet({required this.category, super.key});

  final String category;

  @override
  State<AddInstructionSheet> createState() => _AddInstructionSheetState();
}

class _AddInstructionSheetState extends State<AddInstructionSheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ingredients = <String, List<Ingredient>>{};
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.category == 'recipe' ? s.addRecipe : s.addInstruction,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8.0),
            TextField(
              maxLines: null,
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 150,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  children: [
                    ...ingredients.entries.map(
                      (ingredientList) => SizedBox(
                        width: 150,
                        child: ListView(
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  final ingr = await showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          const AddIngredientSheet());
                                  if (ingr != null) {
                                    final List<Ingredient> newIngrList = [
                                      ...ingredientList.value,
                                      ingr
                                    ];
                                    setState(() =>
                                        ingredients[ingredientList.key] =
                                            newIngrList);
                                  }
                                },
                                child: SizedBox(
                                    height: 30, child: Text(s.addIngredient))),
                            ...ingredientList.value.map((e) => ElevatedButton(
                                onPressed: () {}, child: Text(e.name))),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () => setState(() =>
                            ingredients[(ingredients.length + 1).toString()] =
                                []),
                        child:
                            SizedBox(height: 30, child: Text(s.addIngredient))),
                  ]),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(
                  context,
                  widget.category == 'recipe'
                      ? Recipe(
                          title: titleController.text,
                          description: descriptionController.text,
                          ingredients: ingredients,
                        )
                      : Instruction(
                          title: titleController.text,
                          description: descriptionController.text,
                          category: widget.category,
                        )),
              child: Text(s.saveInstruction),
            ),
          ],
        ),
      ),
    );
  }
}
