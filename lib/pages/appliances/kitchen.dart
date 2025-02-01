import 'package:altag/pages/appliances/coffee_maker.dart';
import 'package:altag/pages/appliances/kettle.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class KitchenAppliancesPage extends StatelessWidget {
  const KitchenAppliancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.kitchenAppliancesTitle)),
      body: ListView(children: [
        ListTile(
          leading: const Icon(Icons.heat_pump),
          title: Text(s.kitchenStoveTitle),
          subtitle: Text(s.kitchenStoveSubtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          leading: const Icon(Icons.microwave),
          title: Text(s.kitchenMicrowaveTitle),
          subtitle: Text(s.kitchenMicrowaveSubtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          leading: const Icon(Icons.album),
          title: Text(s.kitchenOvenTitle),
          subtitle: Text(s.kitchenOvenSubtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          leading: const Icon(Icons.label),
          title: Text(s.kitchenFridgeTitle),
          subtitle: Text(s.kitchenFridgeSubtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
            leading: const Icon(Icons.h_mobiledata),
            title: Text(s.kitchenKettleTitle),
            subtitle: Text(s.kitchenKettleSubtitle),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KettlePage()),
                )),
        ListTile(
          leading: const Icon(Icons.breakfast_dining),
          title: Text(s.kitchenToasterTitle),
          subtitle: Text(s.kitchenToasterSubtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          leading: const Icon(Icons.coffee),
          title: Text(s.kitchenCoffeeMakerTitle),
          subtitle: Text(s.kitchenCoffeeMakerSubtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CoffeeMakerPage()),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.electric_bike),
          title: Text(s.kitchenCounterPlugsTitle),
          subtitle: Text(s.kitchenCounterPlugsSubtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ]),
    );
  }
}
