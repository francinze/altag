import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class UtilitiesPage extends StatelessWidget {
  const UtilitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(texts.utilitiesTitle)),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text(texts.waterShutOffTitle),
            subtitle: Text(texts.waterShutOffSubtitle),
            children: <Widget>[
              ListTile(
                title: Text(texts.waterShutOffLocationTitle),
                subtitle: Text(texts.waterShutOffLocationSubtitle),
              ),
              ListTile(
                title: Text(texts.waterShutOffInstructionsTitle),
                subtitle: Text(texts.waterShutOffInstructionsSubtitle),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(texts.powerOutageTitle),
            subtitle: Text(texts.powerOutageSubtitle),
            children: <Widget>[
              ListTile(
                title: Text(texts.powerOutageWhatToDoTitle),
                subtitle: Text(texts.powerOutageWhatToDoSubtitle),
              ),
              ListTile(
                title: Text(texts.powerOutageSafetyPrecautionsTitle),
                subtitle: Text(texts.powerOutageSafetyPrecautionsSubtitle),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(texts.hvacTitle),
            subtitle: Text(texts.hvacSubtitle),
            children: <Widget>[
              ListTile(
                title: Text(texts.hvacThermostatLocationTitle),
                subtitle: Text(texts.hvacThermostatLocationSubtitle),
              ),
              ListTile(
                title: Text(texts.hvacTemperatureSettingsTitle),
                subtitle: Text(texts.hvacTemperatureSettingsSubtitle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
