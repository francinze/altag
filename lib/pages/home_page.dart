import 'package:altag/pages/recipes.dart';
import 'package:altag/pages/utilities.dart';
import 'package:altag/pages/whiteboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.house_instructions_title,
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
                  label: AppLocalizations.of(context)!.utilities_title,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UtilitiesPage())),
                ),
                _CategoryCard(
                  icon: Icons.kitchen,
                  label: AppLocalizations.of(context)!.appliances_title,
                  onTap: () {
                    // Navigate to Appliances page
                  },
                ),
                _CategoryCard(
                  icon: Icons.book,
                  label: AppLocalizations.of(context)!.recipes_title,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecipesPage()),
                  ),
                ),
                _CategoryCard(
                  icon: Icons.cleaning_services,
                  label: AppLocalizations.of(context)!.housekeeping_title,
                  onTap: () {
                    // Navigate to Housekeeping page
                  },
                ),
                _CategoryCard(
                  icon: Icons.notes,
                  label: AppLocalizations.of(context)!.whiteboard_title,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WhiteboardPage()),
                  ),
                ),
              ],
            ),
          ),
        ],
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
