import 'package:flutter/material.dart';

class InventorySummaryCard extends StatelessWidget {
  const InventorySummaryCard({
    super.key,
    required this.totalProducts,
    required this.totalLocations,
    required this.totalInventory,
  });

  final int totalProducts;
  final int totalLocations;
  final double totalInventory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _SummaryItem(
              label: 'Productos',
              value: '$totalProducts',
              icon: Icons.inventory_2_outlined,
              color: theme.colorScheme.primary,
            ),
            _SummaryItem(
              label: 'Ubicaciones',
              value: '$totalLocations',
              icon: Icons.home_work_outlined,
              color: theme.colorScheme.secondary,
            ),
            _SummaryItem(
              label: 'Stock total',
              value: totalInventory.toStringAsFixed(2),
              icon: Icons.add_box_outlined,
              color: theme.colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.12),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

