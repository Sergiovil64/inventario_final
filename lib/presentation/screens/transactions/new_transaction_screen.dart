import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/inventory/transaction_form_event.dart';
import 'package:inventario_final/bloc/inventory/transaction_form_state.dart';
import 'package:inventario_final/data/repositories/auth_repository.dart';
import 'package:inventario_final/data/repositories/inventory_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../bloc/inventory/transaction_form_bloc.dart';
import '../../../models/enums.dart';

class NewTransactionScreen extends StatelessWidget {
  const NewTransactionScreen({super.key});

  static const routeName = '/transactions/new';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Movimiento')),
      body: BlocProvider(
        create: (context) => TransactionFormBloc(
          repository: context.read<InventoryRepository>(),
          authRepository: context.read<AuthRepository>(),
          uuid: const Uuid(),
        )..add(const TransactionFormInitialized()),
        child: const _TransactionForm(),
      ),
    );
  }
}

class _TransactionForm extends StatefulWidget {
  const _TransactionForm();

  @override
  State<_TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<_TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _referenceController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _quantityController.dispose();
    _referenceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  IconData _getTransactionIcon(TransactionType type) {
    switch (type) {
      case TransactionType.purchase:
        return Icons.shopping_cart;
      case TransactionType.sale:
        return Icons.point_of_sale;
      case TransactionType.transfer:
        return Icons.swap_horiz;
      case TransactionType.adjustment:
        return Icons.tune;
    }
  }

  Color _getTransactionColor(TransactionType type) {
    switch (type) {
      case TransactionType.purchase:
        return Colors.green;
      case TransactionType.sale:
        return Colors.blue;
      case TransactionType.transfer:
        return Colors.orange;
      case TransactionType.adjustment:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionFormBloc, TransactionFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == TransactionFormStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Movimiento registrado correctamente'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        } else if (state.status == TransactionFormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Error al registrar movimiento'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<TransactionFormBloc, TransactionFormState>(
        builder: (context, state) {
          if (state.status == TransactionFormStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Tipo de Movimiento - Prominente
                Text(
                  'Tipo de Movimiento',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: DropdownButtonFormField<TransactionType>(
                      value: state.transactionType,
                      decoration: InputDecoration(
                        labelText: 'Selecciona el tipo *',
                        border: const OutlineInputBorder()
                      ),
                      items: TransactionType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Row(
                            children: [
                              Icon(
                                _getTransactionIcon(type),
                                color: _getTransactionColor(type),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                type.value.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: _getTransactionColor(type),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<TransactionFormBloc>()
                              .add(TransactionFormTypeChanged(value));
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),

                // Sección de Producto
                Text(
                  'Detalles del Movimiento',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                // Producto
                DropdownButtonFormField<String>(
                  value: state.productId,
                  decoration: const InputDecoration(
                    labelText: 'Producto *',
                    hintText: 'Selecciona un producto',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.inventory_2),
                  ),
                  items: state.products.map((product) {
                    return DropdownMenuItem(
                      value: product.id,
                      child: Text(product.name),
                    );
                  }).toList(),
                  onChanged: (value) => context
                      .read<TransactionFormBloc>()
                      .add(TransactionFormProductChanged(value)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Selecciona un producto';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Cantidad
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Cantidad *',
                    hintText: '0',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.production_quantity_limits),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  onChanged: (value) => context
                      .read<TransactionFormBloc>()
                      .add(TransactionFormQuantityChanged(double.tryParse(value) ?? 0)),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa la cantidad';
                    }
                    final qty = double.tryParse(value);
                    if (qty == null || qty <= 0) {
                      return 'La cantidad debe ser mayor a 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Ubicaciones según el tipo
                if (state.transactionType == TransactionType.sale ||
                    state.transactionType == TransactionType.transfer) ...[
                  DropdownButtonFormField<String?>(
                    value: state.sourceLocationId,
                    decoration: const InputDecoration(
                      labelText: 'Ubicación de Origen *',
                      hintText: 'Desde donde sale',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on, color: Colors.red),
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Selecciona ubicación'),
                      ),
                      ...state.locations.map((location) {
                        return DropdownMenuItem<String?>(
                          value: location.id,
                          child: Text('${location.name} (${location.type.value})'),
                        );
                      }),
                    ],
                    onChanged: (value) => context
                        .read<TransactionFormBloc>()
                        .add(TransactionFormSourceChanged(value)),
                    validator: (value) {
                      if (state.transactionType == TransactionType.sale ||
                          state.transactionType == TransactionType.transfer) {
                        if (value == null || value.isEmpty) {
                          return 'Selecciona la ubicación de origen';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                ],

                if (state.transactionType == TransactionType.purchase ||
                    state.transactionType == TransactionType.transfer ||
                    state.transactionType == TransactionType.adjustment) ...[
                  DropdownButtonFormField<String?>(
                    value: state.targetLocationId,
                    decoration: const InputDecoration(
                      labelText: 'Ubicación de Destino *',
                      hintText: 'Hacia donde va',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on, color: Colors.green),
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Selecciona ubicación'),
                      ),
                      ...state.locations.map((location) {
                        return DropdownMenuItem<String?>(
                          value: location.id,
                          child: Text('${location.name} (${location.type.value})'),
                        );
                      }),
                    ],
                    onChanged: (value) => context
                        .read<TransactionFormBloc>()
                        .add(TransactionFormTargetChanged(value)),
                    validator: (value) {
                      if (state.transactionType == TransactionType.purchase ||
                          state.transactionType == TransactionType.transfer ||
                          state.transactionType == TransactionType.adjustment) {
                        if (value == null || value.isEmpty) {
                          return 'Selecciona la ubicación de destino';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                ],

                // Validación de transferencia
                if (state.transactionType == TransactionType.transfer &&
                    state.sourceLocationId != null &&
                    state.targetLocationId != null &&
                    state.sourceLocationId == state.targetLocationId) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red.shade700),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'El origen y destino deben ser diferentes',
                            style: TextStyle(
                              color: Colors.red.shade900,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                const Divider(),
                const SizedBox(height: 16),

                // Información Adicional
                Text(
                  'Información Adicional',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                // Referencia
                TextFormField(
                  controller: _referenceController,
                  decoration: const InputDecoration(
                    labelText: 'Referencia',
                    hintText: 'Ej: Factura #001, Orden #123',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.tag),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  onChanged: (value) => context
                      .read<TransactionFormBloc>()
                      .add(TransactionFormReferenceChanged(value)),
                ),
                const SizedBox(height: 16),

                // Nota
                TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Notas',
                    hintText: 'Información adicional (opcional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.note),
                  ),
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) => context
                      .read<TransactionFormBloc>()
                      .add(TransactionFormNoteChanged(value)),
                ),

                const SizedBox(height: 24),

                // Panel de validación (temporal)
                if (!state.isValid) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.warning_amber, color: Colors.orange.shade700, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Completa los siguientes campos:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (state.productId == null) const Text('• Producto'),
                        if (state.quantity <= 0) const Text('• Cantidad válida'),
                        if (state.transactionType == TransactionType.transfer &&
                            (state.sourceLocationId == null || state.targetLocationId == null))
                          const Text('• Ubicaciones de origen y destino'),
                        if (state.transactionType == TransactionType.transfer &&
                            state.sourceLocationId != null &&
                            state.targetLocationId != null &&
                            state.sourceLocationId == state.targetLocationId)
                          const Text('• Ubicaciones diferentes para transferencia'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Botón de guardar
                ElevatedButton.icon(
                  onPressed: state.isValid
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            context.read<TransactionFormBloc>().add(const TransactionFormSubmitted());
                          }
                        }
                      : null,
                  icon: const Icon(Icons.save),
                  label: const Text('Registrar Movimiento'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

