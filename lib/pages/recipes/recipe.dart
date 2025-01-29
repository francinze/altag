import 'package:altag/providers/firestore_service.dart';
import 'package:altag/widgets/ingredient_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/recipe.dart';
import '../../providers/auth.dart';
import '../../sheets/add_instruction_sheet.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as RecipePageArguments;
    final firestore = Provider.of<FirestoreService>(context);
    return StreamBuilder<Map<String, List<Ingredient>>>(
        stream: firestore.getIngredientsByRecipe(args.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final ingredients = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(args.recipe.title),
              actions: [
                if (Provider.of<HouseAuthProvider>(context).user != null)
                  IconButton(
                      onPressed: () async {
                        final (
                          Recipe? recipe,
                          Map<String, List<Ingredient>> ingrList
                        ) = await showModalBottomSheet(
                            context: context,
                            enableDrag: false,
                            isScrollControlled: true,
                            builder: (context) => AddInstructionSheet(
                                  instruction: args.recipe,
                                  ingredients: ingredients,
                                ));
                        if (recipe != null) {
                          firestore.updateInstruction(
                              recipe, args.id, ingrList);
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.edit))
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Text(args.recipe.description)),
                  Column(
                    children: [
                      ...snapshot.data!.entries.map((entry) {
                        return Column(
                          children: [
                            Text(entry.key,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            SizedBox(
                              height: 250,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: entry.value
                                    .asMap()
                                    .entries
                                    .map((i) => IngredientTile(
                                          i: i,
                                          updateIngredient: (newI) {
                                            final newList = entry.value;
                                            newList[i.key] = newI;
                                            firestore.updateIngredient(
                                                args.id, entry.key, newList);
                                          },
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        );
                      })
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class RecipePageArguments {
  final String id;
  final Recipe recipe;
  RecipePageArguments(this.id, this.recipe);
}
