import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/recipe.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;
  const RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: Column(
        children: [
          Text(recipe.description),
          Column(
            children: recipe.ingredients.entries.map((entry) {
              return SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: entry.value
                      .map((i) => SizedBox(
                            width: 200,
                            child: Column(
                              children: [
                                Text(i.name),
                                Text(i.description),
                                TextButton(
                                    onPressed: () =>
                                        launchUrlString(i.productUrl),
                                    child: const Text('LINK')),
                                Image.asset('assets/ingredients/${i.imageUrl!}',
                                    width: 100, height: 100),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
