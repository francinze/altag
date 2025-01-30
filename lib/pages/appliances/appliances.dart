import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class AppliancesPage extends StatelessWidget {
  const AppliancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.appliancesTitle)),
      body: ListView(children: [
        ListTile(
          leading: const Icon(Icons.restaurant),
          title: Text(s.kitchenAppliancesTitle),
          subtitle: Text(s.kitchenAppliancesSubtitle),
          onTap: () => Navigator.pushNamed(context, '/kitchen'),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ]),
    );
  }
}
