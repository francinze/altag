import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../widgets/image_tooltip.dart';

class KettlePage extends StatelessWidget {
  const KettlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
        appBar: AppBar(
            title: Text(s.kitchenKettleTitle,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Center(
                    child: Column(
              children: [
                Text(s.kitchenKettleSubtitle,
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Text(s.kitchenKettleInstructions,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Stack(children: [
                  Image.asset('assets/appliances/bollitore.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.contain),
                  ImageTooltip(s.kitchenKettleButtonLabel, 0.21, 0.6),
                  ImageTooltip(s.kitchenKettleHandleLabel, 0.46, 0.55),
                  ImageTooltip(s.plugLabel, 0.36, 0.56),
                ]),
              ],
            )))));
  }
}
