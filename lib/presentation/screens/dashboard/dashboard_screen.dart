import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/authentication/authentication_bloc.dart';
import '../../../bloc/inventory/inventory_overview_bloc.dart';
import '../../../bloc/sync/sync_bloc.dart';
import '../../../data/repositories/inventory_repository.dart';
import '../../widgets/inventory_summary_card.dart';
import '../../widgets/sync_status_banner.dart';
import '../auth/login_screen.dart';
import '../products/product_list_screen.dart';
import '../transactions/new_transaction_screen.dart';

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

        return Scaffold(
          appBar: AppBar(
            title: const Text('Inventario - Dashboard'),
            actions: [
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () => context.read<AuthenticationBloc>().add(
                      const AuthenticationLogoutRequested(),
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.pushNamed(context, NewTransactionScreen.routeName),
              ),
              IconButton(
                icon: const Icon(Icons.store_outlined),
                onPressed: () => Navigator.pushNamed(context, ProductListScreen.routeName),
              ),
            ],
          ),
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => InventoryOverviewBloc(context.read<InventoryRepository>())
                  ..add(const InventoryOverviewSubscriptionRequested()),
              ),
            ],
            child: const _DashboardView(),
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
    return BlocBuilder<InventoryOverviewBloc, InventoryOverviewState>(
      builder: (context, state) {
        if (state.status == InventoryOverviewStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == InventoryOverviewStatus.failure) {
          return Center(child: Text(state.errorMessage ?? 'Error desconocido'));
        }

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
              const SyncStatusBanner(),
              const SizedBox(height: 16),
              InventorySummaryCard(
                totalProducts: state.products.length,
                totalLocations: state.snapshots.map((e) => e.locationId).toSet().length,
                totalInventory: state.inventoryTotals.values.fold<double>(
                  0,
                  (previousValue, element) => previousValue + element,
                ),
              ),
              const SizedBox(height: 24),
              Text('Top productos', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              ...state.products.take(5).map(
                (product) => ListTile(
                  title: Text(product.name),
                  subtitle: Text('SKU: ${product.sku}'),
                  trailing: Text(
                    (state.inventoryTotals[product.id] ?? 0).toStringAsFixed(2),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

