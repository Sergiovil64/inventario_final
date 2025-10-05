import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_state.dart';
import '../../../bloc/inventory/inventory_overview_bloc.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  static const routeName = '/products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/products/form');
          // La lista se actualiza automáticamente al volver
          // porque InventoryOverviewBloc escucha cambios en watchProducts()
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Producto'),
      ),
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
            padding: const EdgeInsets.all(8),
            itemCount: state.products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final product = state.products[index];
              final stock = state.inventoryTotals[product.id] ?? 0;
              final hasStock = stock > 0;
              
              return Card(
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: hasStock ? Colors.green.shade100 : Colors.red.shade100,
                    child: Icon(
                      Icons.inventory_2,
                      color: hasStock ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                  title: Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('SKU: ${product.sku}'),
                      Text('Categoría: ${product.category}'),
                      Text('Unidad: ${product.unit}'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'S/ ${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: hasStock ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: hasStock ? Colors.green.shade300 : Colors.red.shade300,
                          ),
                        ),
                        child: Text(
                          'Stock: ${stock.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: hasStock ? Colors.green.shade700 : Colors.red.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    // Navegar al formulario de edición
                    await Navigator.pushNamed(
                      context,
                      '/products/form',
                      arguments: {'productId': product.id},
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

