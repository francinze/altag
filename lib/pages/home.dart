import 'package:altag/pages/dashboard.dart';
import 'package:altag/pages/search.dart';
import 'package:altag/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  void onPageSelected(int index) => setState(() => selectedIndex = index);

  final List<Widget> pages = [
    const DashboardPage(),
    const SearchPage(),
    const SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<HouseAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('AltaGuardiaHub')),
      floatingActionButton: auth.user == null
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.pushNamed(context, '/unauth'),
              label: const Text('Login'),
              icon: const Icon(Icons.login),
            )
          : null,
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onPageSelected,
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.home), label: SizedBox()),
              NavigationRailDestination(
                  icon: Icon(Icons.search), label: SizedBox()),
              NavigationRailDestination(
                  icon: Icon(Icons.settings), label: SizedBox()),
            ],
          ),
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}
