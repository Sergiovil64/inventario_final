import 'package:flutter/material.dart';
import 'package:inventario_final/models/entities.dart';

class EnhancedInventorySummary extends StatelessWidget {
  const EnhancedInventorySummary({
    super.key,
    required this.totalProducts,
    required this.currentLocationStock,
    required this.globalStock,
    required this.isGlobalView,
    required this.selectedLocation,
    required this.totalLocations,
  });

  final int totalProducts;
  final double currentLocationStock;
  final double globalStock;
  final bool isGlobalView;
  final LocationEntity? selectedLocation;
  final int totalLocations;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Card principal con stock destacado
        Card(
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primaryContainer,
                  theme.colorScheme.secondaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Título con ubicación
                  Row(
                    children: [
                      Icon(
                        isGlobalView ? Icons.public : Icons.location_on,
                        color: theme.colorScheme.onPrimaryContainer,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isGlobalView ? 'Vista Global' : 'Ubicación Actual',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                              ),
                            ),
                            Text(
                              isGlobalView 
                                  ? 'Todas las ubicaciones' 
                                  : selectedLocation?.name ?? 'Sin ubicación',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  // Estadísticas principales
                  Row(
                    children: [
                      Expanded(
                        child: _StatItem(
                          label: 'Productos',
                          value: totalProducts.toString(),
                          icon: Icons.inventory_2,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 60,
                        color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.2),
                      ),
                      Expanded(
                        child: _StatItem(
                          label: 'Ubicaciones',
                          value: totalLocations.toString(),
                          icon: Icons.store,
                          color: theme.colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Cards de stock comparativo
        Row(
          children: [
            Expanded(
              child: _StockComparisonCard(
                title: 'Stock Ubicación',
                subtitle: selectedLocation?.name ?? 'Actual',
                value: currentLocationStock,
                icon: Icons.store,
                color: theme.colorScheme.primary,
                isPrimary: !isGlobalView,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StockComparisonCard(
                title: 'Stock Global',
                subtitle: 'Todas las ubicaciones',
                value: globalStock,
                icon: Icons.public,
                color: theme.colorScheme.secondary,
                isPrimary: isGlobalView,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
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
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}

class _StockComparisonCard extends StatelessWidget {
  const _StockComparisonCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
    required this.color,
    required this.isPrimary,
  });

  final String title;
  final String subtitle;
  final double value;
  final IconData icon;
  final Color color;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: isPrimary ? 4 : 2,
      child: Container(
        decoration: BoxDecoration(
          border: isPrimary 
              ? Border.all(color: color, width: 2)
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  if (isPrimary) ...[
                    const Spacer(),
                    Icon(
                      Icons.check_circle,
                      color: color,
                      size: 20,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                value.toStringAsFixed(1),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                'unidades',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: color.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


