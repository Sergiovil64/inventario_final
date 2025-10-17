import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/authentication/authentication_bloc.dart';
import 'package:inventario_final/bloc/authentication/authentication_event.dart';
import 'package:inventario_final/bloc/authentication/authentication_state.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_bloc.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_event.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_state.dart';
import 'package:inventario_final/models/entities.dart';
import 'package:inventario_final/models/enums.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        return BlocBuilder<InventoryOverviewBloc, InventoryOverviewState>(
          builder: (context, inventoryState) {
            if (authState.user == null || inventoryState.locations.isEmpty) {
              return const SizedBox.shrink();
            }

            final currentUser = authState.user!;
            final locations = inventoryState.locations;
            final selectedLocationId = inventoryState.selectedLocationId ?? currentUser.locationId;

            return Card(
              margin: const EdgeInsets.all(0),
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.location_on,
                          size: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Filtro de ubicación',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(height: 4),
                            DropdownButton<String>(
                              isExpanded: true,
                              value: selectedLocationId.isEmpty ? null : selectedLocationId,
                              hint: const Text('Todas las ubicaciones'),
                              underline: const SizedBox.shrink(),
                              icon: const Icon(Icons.arrow_drop_down, size: 28),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              items: [
                                DropdownMenuItem<String>(
                                  value: null,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.public,
                                        size: 18,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text('Todas las ubicaciones'),
                                    ],
                                  ),
                                ),
                                ...locations.map((location) {
                                  return DropdownMenuItem<String>(
                                    value: location.id,
                                    child: Row(
                                      children: [
                                        Icon(
                                          location.type == LocationType.store
                                              ? Icons.store
                                              : Icons.warehouse,
                                          size: 18,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            location.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (location.id == currentUser.locationId)
                                          Container(
                                            margin: const EdgeInsets.only(left: 8),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.primary,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'TU',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).colorScheme.onPrimary,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                              onChanged: (value) {
                                // Actualizar la ubicación seleccionada para el filtro de inventario
                                context.read<InventoryOverviewBloc>().add(
                                      InventoryOverviewLocationChanged(value),
                                    );

                                // Si se selecciona una ubicación específica, actualizar la ubicación del empleado
                                if (value != null && value != currentUser.locationId) {
                                  _showLocationChangeDialog(context, value, locations);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showLocationChangeDialog(
    BuildContext context,
    String newLocationId,
    List<LocationEntity> locations,
  ) {
    final location = locations.firstWhere((l) => l.id == newLocationId);
    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cambiar ubicación'),
        content: Text(
          '¿Deseas cambiar tu ubicación permanente a "${location.name}"?\n\n'
          'Esto actualizará tu ubicación de trabajo predeterminada.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(
                    AuthenticationLocationChanged(newLocationId: newLocationId),
                  );
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Ubicación cambiada a ${location.name}'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Cambiar'),
          ),
        ],
      ),
    );
  }
}

