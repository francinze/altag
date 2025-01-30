import 'package:altag/generated/l10n.dart';
import 'package:altag/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<HouseAuthProvider>(context);
    final user = authProvider.user;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            S.of(context).houseInstructionsTitle,
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
                  label: S.of(context).utilitiesTitle,
                  onTap: () => Navigator.pushNamed(context, '/utilities'),
                ),
                _CategoryCard(
                  icon: Icons.kitchen,
                  label: S.of(context).appliancesTitle,
                  onTap: () => Navigator.pushNamed(context, '/appliances'),
                ),
                _CategoryCard(
                  icon: Icons.book,
                  label: S.of(context).recipesTitle,
                  onTap: () => Navigator.pushNamed(context, '/recipes'),
                ),
                _CategoryCard(
                  icon: Icons.cleaning_services,
                  label: S.of(context).housekeepingTitle,
                  onTap: () {
                    // Navigate to Housekeeping page
                  },
                ),
                if (user != null)
                  _CategoryCard(
                    icon: Icons.notes,
                    label: S.of(context).whiteboardTitle,
                    onTap: () => Navigator.pushNamed(context, '/whiteboard'),
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
