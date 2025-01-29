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
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
                widget.instruction.category == 'recipe'
                    ? s.addRecipe
                    : s.addInstruction,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: s.instructionTitleLabel),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: null,
              controller: descriptionController,
              decoration:
                  InputDecoration(labelText: s.instructionDescriptionLabel),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: [
                    ...ingredients.map(
                      (controller, ingredientList) {
                        return MapEntry(
                            controller,
                            Padding(
                              padding: const EdgeInsets.all(3),
                              child: SizedBox(
                                height: 150,
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
                                        child: Text(s.addIngredientOption,
                                            style:
                                                const TextStyle(fontSize: 11))),
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
              onPressed: () {
                print(descriptionController.text);
                Navigator.pop(context, (
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
                ));
              },
              child: Text(s.saveInstruction),
            ),
          ],
        ),
      ),
    );
  }
}
