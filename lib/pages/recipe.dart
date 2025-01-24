import 'package:altag/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/recipe.dart';
import '../providers/auth.dart';
import '../sheets/add_ingredient_sheet.dart';
import '../sheets/add_instruction_sheet.dart';

class RecipePage extends StatefulWidget {
  final String id;
  final Recipe recipe;
  const RecipePage({super.key, required this.id, required this.recipe});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, List<Ingredient>>>(
        stream: FirestoreService.getIngredientsByRecipe(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final ingredients = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.recipe.title),
              actions: [
                if (Provider.of<HouseAuthProvider>(context).user != null)
                  IconButton(
                      onPressed: () async {
                        final (
                          Recipe? recipe,
                          Map<String, List<Ingredient>> ingrList
                        ) = await showModalBottomSheet(
                            context: context,
                            builder: (context) => AddInstructionSheet(
                                  instruction: widget.recipe,
                                  ingredients: ingredients,
                                ));
                        if (recipe != null) {
                          FirestoreService.updateInstruction(
                              recipe, widget.id, ingrList);
                        }
                      },
                      icon: const Icon(Icons.edit))
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Text(widget.recipe.description)),
                Column(
                  children: [
                    ...snapshot.data!.entries.map((entry) {
                      return Column(
                        children: [
                          Text(entry.key),
                          SizedBox(
                            height: 250,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: entry.value
                                  .asMap()
                                  .entries
                                  .map((i) => SizedBox(
                                        width: 200,
                                        child: GestureDetector(
                                          onTap: () async {
                                            final ingr =
                                                await showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        AddIngredientSheet(
                                                            ingredient:
                                                                i.value));
                                            final newList = entry.value;
                                            newList[i.key] = ingr;
                                            if (ingr != null) {
                                              FirestoreService.updateIngredient(
                                                  widget.id,
                                                  entry.key,
                                                  newList);
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              Text(i.value.name),
                                              Text(i.value.description),
                                              TextButton(
                                                  onPressed: () =>
                                                      launchUrlString(
                                                          i.value.productUrl),
                                                  child: const Text('LINK')),
                                              Image.asset(
                                                  'assets/ingredients/${i.value.imageUrl!}',
                                                  width: 100,
                                                  height: 100),
                                            ],
                                          ),
                                        ),
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
          );
        });
  }
}
