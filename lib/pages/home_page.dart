import 'package:altag/pages/utilities.dart';
import 'package:altag/pages/whiteboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message('House Instructions', name: 'homepage_title')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Intl.message(
                'Welcome! Select a category to get started:',
                name: 'homepage_welcome',
              ),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                children: [
                  _CategoryCard(
                    icon: Icons.plumbing,
                    label: Intl.message('Utilities', name: 'utilities'),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UtilitiesPage())),
                  ),
                  _CategoryCard(
                    icon: Icons.kitchen,
                    label: Intl.message('Appliances', name: 'appliances'),
                    onTap: () {
                      // Navigate to Appliances page
                    },
                  ),
                  _CategoryCard(
                    icon: Icons.book,
                    label: Intl.message('Recipes', name: 'recipes'),
                    onTap: () {
                      // Navigate to Recipes page
                    },
                  ),
                  _CategoryCard(
                    icon: Icons.cleaning_services,
                    label: Intl.message('Housekeeping', name: 'housekeeping'),
                    onTap: () {
                      // Navigate to Housekeeping page
                    },
                  ),
                  _CategoryCard(
                    icon: Icons.notes,
                    label: Intl.message('Whiteboard', name: 'whiteboard'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WhiteboardPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onDestinationSelected: (index) {
          // Handle navigation between pages
        },
        selectedIndex: 0, // Home is selected
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
