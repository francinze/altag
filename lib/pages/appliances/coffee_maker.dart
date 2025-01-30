import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class CoffeeMakerPage extends StatelessWidget {
  const CoffeeMakerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(s.kitchenCoffeeMakerTitle,
              style: const TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(children: [
            Text(s.kitchenCoffeeMakerSubtitle,
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text(s.kitchenCoffeeMakerInstructions,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Image.asset('assets/appliances/caffettiera.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                fit: BoxFit.contain),
          ]),
        ),
      ),
    );
  }
}
