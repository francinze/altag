import 'package:altag/pages/dashboard.dart';
import 'package:altag/pages/search.dart';
import 'package:altag/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  void onPageSelected(int index) => setState(() => selectedIndex = index);
  User? _user;

  final List<Widget> pages = [
    const DashboardPage(),
    const SearchPage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Listen for auth state changes
    FirebaseAuth.instance
        .authStateChanges()
        .listen((user) => setState(() => _user = user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AltaGuardiaHub')),
      floatingActionButton: _user == null
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
