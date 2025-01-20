import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({required this.onChangeLocale, super.key});

  final void Function(Locale locale) onChangeLocale;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () => onChangeLocale(const Locale('en')),
              child: const Text('English'),
            ),
            ElevatedButton(
              onPressed: () => onChangeLocale(const Locale('it')),
              child: const Text('Italiano'),
            ),
          ],
        ),
      ],
    );
  }
}
