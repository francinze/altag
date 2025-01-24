import 'package:altag/models/recipe.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../models/instruction.dart';
import 'add_ingredient_sheet.dart';

class AddInstructionSheet extends StatefulWidget {
  const AddInstructionSheet(
      {required this.instruction, this.ingredients, super.key});

  final Instruction instruction;
  final Map<String, List<Ingredient>>? ingredients;

  @override
  State<AddInstructionSheet> createState() => _AddInstructionSheetState();
}

class _AddInstructionSheetState extends State<AddInstructionSheet> {
  Map<TextEditingController, List<Ingredient>> ingredients = {};
  @override
  void initState() {
    super.initState();
    if (widget.ingredients == null) {
      ingredients = {};
    } else {
      ingredients = widget.ingredients!.map(
          (key, value) => MapEntry(TextEditingController(text: key), value));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final titleController =
        TextEditingController(text: widget.instruction.title);
    final descriptionController =
        TextEditingController(text: widget.instruction.description);
    final s = S.of(context);
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                widget.instruction.category == 'recipe'
                    ? s.addRecipe
                    : s.addInstruction,
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
                  padding: const EdgeInsets.all(4),
                  children: [
                    ...ingredients.map(
                      (controller, ingredientList) {
                        return MapEntry(
                            controller,
                            Padding(
                              padding: const EdgeInsets.all(3),
                              child: SizedBox(
                                width: 150,
                                child: ListView(
                                  children: [
                                    TextField(controller: controller),
                                    ElevatedButton(
                                        onPressed: () async {
                                          final ingr = await showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  const AddIngredientSheet());
                                          if (ingr != null) {
                                            final List<Ingredient> newIngrList =
                                                [...ingredientList, ingr];
                                            setState(() =>
                                                ingredients[controller] =
                                                    newIngrList);
                                          }
                                        },
                                        child: SizedBox(
                                            height: 30,
                                            child: Text(s.addIngredient))),
                                    ...ingredientList.map((e) => Text(e.name)),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ).values,
                    ElevatedButton(
                        onPressed: () => setState(
                            () => ingredients[TextEditingController()] = []),
                        child:
                            SizedBox(height: 30, child: Text(s.addIngredient))),
                  ]),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, (
                widget.instruction.category == 'recipe'
                    ? Recipe(
                        title: titleController.text,
                        description: descriptionController.text,
                      )
                    : Instruction(
                        title: titleController.text,
                        description: descriptionController.text,
                        category: widget.instruction.category,
                      ),
                Map.fromEntries(
                  ingredients.entries
                      .map((entry) => MapEntry(entry.key.text, entry.value)),
                )
              )),
              child: Text(s.saveInstruction),
            ),
          ],
        ),
      ),
    );
  }
}
