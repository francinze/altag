import 'package:altag/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/recipe.dart';
import '../sheets/add_ingredient_sheet.dart';

class RecipePage extends StatelessWidget {
  final String id;
  final Recipe recipe;
  const RecipePage({super.key, required this.id, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: Column(
        children: [
          SizedBox(width: double.infinity, child: Text(recipe.description)),
          StreamBuilder<Map<String, List<Ingredient>>>(
              stream: FirestoreService().getIngredientsByRecipe(id),
              builder: (context, snapshot) {
                return Column(
                  children: snapshot.data!.entries.map((entry) {
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
                                                          ingredient: i.value));
                                          final newList = entry.value;
                                          newList[i.key] = ingr;
                                          if (ingr != null) {
                                            FirestoreService().updateIngredient(
                                                id, entry.key, newList);
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
                  }).toList(),
                );
              })
        ],
      ),
    );
  }
}
