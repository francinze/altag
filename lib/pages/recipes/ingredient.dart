import 'package:altag/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IngredientPage extends StatelessWidget {
  const IngredientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Ingredient;
    return Scaffold(
      appBar: AppBar(
          title: Text(arg.name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
      body: Center(
        child: Column(
          children: [
            Text(arg.description,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center),
            TextButton(
                onPressed: () => launchUrlString(arg.productUrl),
                child: const Text(
                  'LINK',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                )),
            if (arg.imageUrl != null)
              Image.asset('assets/ingredients/${arg.imageUrl!}',
                  width: 300, height: 300),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
