import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class HVACInstructionsPage extends StatelessWidget {
  const HVACInstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = S.of(context);
    return Scaffold(
        appBar: AppBar(title: Text(texts.hvacTitle)),
        body: Column(
          children: [
            Text(
              texts.hvacThermostatLocationTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(texts.hvacThermostatLocationSubtitle),
            Text(
              texts.hvacTemperatureSettingsTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(texts.hvacTemperatureSettingsSubtitle),
          ],
        ));
  }
}
