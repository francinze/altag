import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class PowerInstructionsPage extends StatelessWidget {
  const PowerInstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
        appBar: AppBar(title: Text(s.powerOutageTitle)),
        body: Column(
          children: [
            Text(
              s.powerOutageWhatToDoTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(s.powerOutageWhatToDoSubtitle),
            Text(
              s.powerOutageSafetyPrecautionsTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(s.powerOutageSafetyPrecautionsSubtitle),
          ],
        ));
  }
}
