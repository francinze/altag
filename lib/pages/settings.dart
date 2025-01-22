import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../generated/l10n.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final locale = Intl.getCurrentLocale();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(S.of(context).languageLabel),
            ElevatedButton(
                onPressed: () => setState(() => S.load(const Locale('en'))),
                style: ElevatedButton.styleFrom(
                    backgroundColor: locale == 'en' ? Colors.orange : null),
                child: const Text('English')),
            ElevatedButton(
                onPressed: () => setState(() => S.load(const Locale('it'))),
                style: ElevatedButton.styleFrom(
                    backgroundColor: locale == 'it' ? Colors.orange : null),
                child: const Text('Italiano')),
          ],
        ),
      ],
    );
  }
}
