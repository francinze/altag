import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class UtilitiesPage extends StatelessWidget {
  const UtilitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(texts.utilitiesTitle)),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.water_drop_outlined),
            onTap: () => Navigator.pushNamed(context, '/water'),
            title: Text(texts.waterShutOffTitle),
            subtitle: Text(texts.waterShutOffSubtitle),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: const Icon(Icons.power_outlined),
            onTap: () => Navigator.pushNamed(context, '/power'),
            title: Text(texts.powerOutageTitle),
            subtitle: Text(texts.powerOutageSubtitle),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: const Icon(Icons.hvac),
            onTap: () => Navigator.pushNamed(context, '/hvac'),
            title: Text(texts.hvacTitle),
            subtitle: Text(texts.hvacSubtitle),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
