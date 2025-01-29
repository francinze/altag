import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class WaterInstructionsPage extends StatelessWidget {
  const WaterInstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = S.of(context);
    return Scaffold(
        appBar: AppBar(title: Text(texts.waterShutOffTitle)),
        body: Column(
          children: [
            Text(
              texts.waterShutOffLocationTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(texts.waterShutOffLocationSubtitle),
            Text(
              texts.waterShutOffInstructionsTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(texts.waterShutOffInstructionsSubtitle),
          ],
        ));
  }
}
