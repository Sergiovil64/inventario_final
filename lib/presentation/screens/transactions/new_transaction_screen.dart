import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/inventory/transaction_form_event.dart';
import 'package:inventario_final/bloc/inventory/transaction_form_state.dart';
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
          repository: context.read(),
          uuid: const Uuid(),
        )..add(const TransactionFormInitialized()),
        child: const _TransactionForm(),
      ),
    );
  }
}

class _TransactionForm extends StatelessWidget {
  const _TransactionForm();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionFormBloc, TransactionFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == TransactionFormStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Movimiento registrado correctamente')),
          );
          Navigator.pop(context);
        } else if (state.status == TransactionFormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Error al registrar movimiento')),
          );
        }
      },
      child: BlocBuilder<TransactionFormBloc, TransactionFormState>(
        builder: (context, state) {
          if (state.status == TransactionFormStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: state.productId,
                  decoration: const InputDecoration(labelText: 'Producto'),
                  items: state.products
                      .map((product) => DropdownMenuItem(
                            value: product.id,
                            child: Text(product.name),
                          ))
                      .toList(),
                  onChanged: (value) => context
                      .read<TransactionFormBloc>()
                      .add(TransactionFormProductChanged(value)),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  value: state.sourceLocationId,
                  decoration: const InputDecoration(labelText: 'Origen'),
                  items: [
                    const DropdownMenuItem<String?>(value: null, child: Text('N/A')),
                    ...state.locations.map(
                      (location) => DropdownMenuItem<String?>(
                        value: location.id,
                        child: Text('${location.name} (${location.type.value})'),
                      ),
                    ),
                  ],
                  onChanged: (value) => context
                      .read<TransactionFormBloc>()
                      .add(TransactionFormSourceChanged(value)),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  value: state.targetLocationId,
                  decoration: const InputDecoration(labelText: 'Destino'),
                  items: [
                    const DropdownMenuItem<String?>(value: null, child: Text('N/A')),
                    ...state.locations.map(
                      (location) => DropdownMenuItem<String?>(
                        value: location.id,
                        child: Text('${location.name} (${location.type.value})'),
                      ),
                    ),
                  ],
                  onChanged: (value) => context
                      .read<TransactionFormBloc>()
                      .add(TransactionFormTargetChanged(value)),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: state.quantity.toString(),
                  decoration: const InputDecoration(labelText: 'Cantidad'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => context
                      .read<TransactionFormBloc>()
                      .add(TransactionFormQuantityChanged(double.tryParse(value) ?? 0)),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<TransactionType>(
                  value: state.transactionType,
                  decoration: const InputDecoration(labelText: 'Tipo de movimiento'),
                  items: TransactionType.values
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type.value),
                          ))
                      .toList(),
                  onChanged: (value) => context
                      .read<TransactionFormBloc>()
                      .add(TransactionFormTypeChanged(value ?? TransactionType.purchase)),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: state.reference,
                  decoration: const InputDecoration(labelText: 'Referencia'),
                  onChanged: (value) => context
                      .read<TransactionFormBloc>()
                      .add(TransactionFormReferenceChanged(value)),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: state.note,
                  decoration: const InputDecoration(labelText: 'Nota'),
                  onChanged: (value) => context
                      .read<TransactionFormBloc>()
                      .add(TransactionFormNoteChanged(value)),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: state.isValid
                      ? () => context.read<TransactionFormBloc>().add(const TransactionFormSubmitted())
                      : null,
                  child: const Text('Guardar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

