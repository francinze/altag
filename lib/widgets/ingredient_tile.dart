import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/recipe.dart';
import '../providers/auth.dart';
import '../sheets/add_ingredient_sheet.dart';

class IngredientTile extends StatefulWidget {
  const IngredientTile(
      {super.key, required this.i, required this.updateIngredient});
  final MapEntry<int, Ingredient> i;
  final void Function(Ingredient) updateIngredient;

  @override
  State<IngredientTile> createState() => _IngredientTileState();
}

class _IngredientTileState extends State<IngredientTile> {
  bool showEdit = false;
  @override
  Widget build(BuildContext context) {
    final isAuth = Provider.of<HouseAuthProvider>(context).user != null;
    return InkWell(
      onHover: (hover) {
        if (hover && isAuth) {
          setState(() => showEdit = true);
        } else {
          setState(() => showEdit = false);
        }
      },
      onTap: () => Navigator.pushNamed(context, '/ingredient',
          arguments: widget.i.value),
      child: SizedBox(
        width: 200,
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    widget.i.value.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.i.value.description,
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                      onPressed: () =>
                          launchUrlString(widget.i.value.productUrl),
                      child: const Text('LINK')),
                  Image.asset('assets/ingredients/${widget.i.value.imageUrl!}',
                      width: 100, height: 100),
                ],
              ),
            ),
            if (showEdit)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () async {
                    final Ingredient? ingr = await showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            AddIngredientSheet(ingredient: widget.i.value));
                    if (ingr != null) {
                      widget.updateIngredient(ingr);
                    }
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
