import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/inventory/inventory_overview_bloc.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  static const routeName = '/products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      body: BlocBuilder<InventoryOverviewBloc, InventoryOverviewState>(
        builder: (context, state) {
          if (state.status == InventoryOverviewStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == InventoryOverviewStatus.failure) {
            return Center(child: Text(state.errorMessage ?? 'Error'));
          }
          if (state.products.isEmpty) {
            return const Center(child: Text('No hay productos registrados'));
          }
          return ListView.separated(
            itemCount: state.products.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('SKU: ${product.sku} | ${product.category}'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${product.price.toStringAsFixed(2)} S/'),
                    Text('Stock: ${(state.inventoryTotals[product.id] ?? 0).toStringAsFixed(2)}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

