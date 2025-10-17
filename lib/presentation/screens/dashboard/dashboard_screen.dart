import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/authentication/authentication_bloc.dart';
import 'package:inventario_final/bloc/authentication/authentication_event.dart';
import 'package:inventario_final/bloc/authentication/authentication_state.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_bloc.dart';
import 'package:inventario_final/bloc/sync/sync_bloc.dart';
import 'package:inventario_final/bloc/sync/sync_event.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_event.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_state.dart';
import 'package:inventario_final/presentation/screens/auth/login_screen.dart';
import 'package:inventario_final/presentation/screens/products/product_list_screen.dart';
import 'package:inventario_final/presentation/screens/reports/reports_screen.dart';
import 'package:inventario_final/presentation/screens/transactions/new_transaction_screen.dart';
import 'package:inventario_final/presentation/widgets/location_selector.dart';
import 'package:inventario_final/presentation/widgets/sync_status_banner.dart';
import 'package:inventario_final/presentation/widgets/enhanced_inventory_summary.dart';
import 'package:inventario_final/presentation/widgets/product_stock_card.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        if (authState.status == AuthenticationStatus.unknown ||
            authState.status == AuthenticationStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (authState.status == AuthenticationStatus.unauthenticated ||
            authState.status == AuthenticationStatus.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          });
          return const SizedBox.shrink();
        }

        final user = authState.user!;
        
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dashboard'),
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                tooltip: 'Nueva Transacción',
                onPressed: () => Navigator.pushNamed(context, NewTransactionScreen.routeName),
              ),
              IconButton(
                icon: const Icon(Icons.inventory_2_outlined),
                tooltip: 'Productos',
                onPressed: () => Navigator.pushNamed(context, ProductListScreen.routeName),
              ),
              IconButton(
                icon: const Icon(Icons.analytics_outlined),
                tooltip: 'Reportes',
                onPressed: () => Navigator.pushNamed(context, ReportsScreen.routeName),
              ),
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                tooltip: 'Cerrar Sesión',
                onPressed: () => context.read<AuthenticationBloc>().add(
                      const AuthenticationLogoutRequested(),
                    ),
              ),
            ],
          ),
          body: const _DashboardView(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Navigator.pushNamed(context, NewTransactionScreen.routeName),
            icon: const Icon(Icons.add),
            label: const Text('Nueva Transacción'),
          ),
        );
      },
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        return BlocBuilder<InventoryOverviewBloc, InventoryOverviewState>(
          builder: (context, state) {
            if (state.status == InventoryOverviewStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == InventoryOverviewStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage ?? 'Error desconocido',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }

            final isGlobalView = state.selectedLocationId == null;
            final currentLocationStock = state.inventoryTotals.values.fold<double>(
              0,
              (sum, value) => sum + value,
            );
            
            // Calcular stock global (todos los snapshots)
            final globalStock = state.snapshots.fold<double>(
              0,
              (sum, snapshot) => sum + snapshot.quantity,
            );

            // Obtener la ubicación seleccionada
            final selectedLocation = state.selectedLocationId != null
                ? state.locations.where((l) => l.id == state.selectedLocationId).firstOrNull
                : null;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<InventoryOverviewBloc>().add(
                      const InventoryOverviewSubscriptionRequested(),
                    );
                context.read<SyncBloc>().add(const SyncRequested(force: true));
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Banner de sincronización
                  const SyncStatusBanner(),
                  const SizedBox(height: 16),
                  
                  // Selector de ubicación
                  const LocationSelector(),
                  const SizedBox(height: 20),
                  
                  // Resumen mejorado del inventario
                  EnhancedInventorySummary(
                    totalProducts: state.products.length,
                    currentLocationStock: currentLocationStock,
                    globalStock: globalStock,
                    isGlobalView: isGlobalView,
                    selectedLocation: selectedLocation,
                    totalLocations: state.locations.length,
                  ),
                  const SizedBox(height: 28),
                  
                  // Header de productos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Productos en inventario',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isGlobalView 
                                ? 'Mostrando todas las ubicaciones'
                                : 'Mostrando ubicación actual',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      IconButton.filledTonal(
                        onPressed: () => Navigator.pushNamed(context, ProductListScreen.routeName),
                        icon: const Icon(Icons.arrow_forward),
                        tooltip: 'Ver todos los productos',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Lista de productos con cards mejorados
                  if (state.products.isEmpty)
                    _EmptyState()
                  else
                    ...state.products.take(10).map((product) {
                      final currentStock = state.inventoryTotals[product.id] ?? 0;
                      
                      // Calcular stock global para este producto
                      final productGlobalStock = state.snapshots
                          .where((s) => s.productId == product.id)
                          .fold<double>(0, (sum, s) => sum + s.quantity);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ProductStockCard(
                          product: product,
                          currentLocationStock: currentStock,
                          globalStock: productGlobalStock,
                          isGlobalView: isGlobalView,
                          onTap: () {
                            // Aquí podrías navegar a detalles del producto
                          },
                        ),
                      );
                    }),
                  
                  // Espaciado para el FAB
                  const SizedBox(height: 80),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 80,
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay productos',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Agrega productos para comenzar a gestionar tu inventario',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

