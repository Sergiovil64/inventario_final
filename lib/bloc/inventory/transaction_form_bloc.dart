import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../data/repositories/inventory_repository.dart';
import '../../models/entities.dart';
import '../../models/enums.dart';

part 'transaction_form_event.dart';
part 'transaction_form_state.dart';

class TransactionFormBloc extends Bloc<TransactionFormEvent, TransactionFormState> {
  TransactionFormBloc({
    required InventoryRepository repository,
    required Uuid uuid,
  })  : _repository = repository,
        _uuid = uuid,
        super(const TransactionFormState()) {
    on<TransactionFormInitialized>(_onInitialized);
    on<TransactionFormProductChanged>(_onProductChanged);
    on<TransactionFormSourceChanged>(_onSourceChanged);
    on<TransactionFormTargetChanged>(_onTargetChanged);
    on<TransactionFormQuantityChanged>(_onQuantityChanged);
    on<TransactionFormTypeChanged>(_onTypeChanged);
    on<TransactionFormReferenceChanged>(_onReferenceChanged);
    on<TransactionFormNoteChanged>(_onNoteChanged);
    on<TransactionFormEmployeeChanged>(_onEmployeeChanged);
    on<TransactionFormSubmitted>(_onSubmitted);
  }

  final InventoryRepository _repository;
  final Uuid _uuid;

  Future<void> _onInitialized(
    TransactionFormInitialized event,
    Emitter<TransactionFormState> emit,
  ) async {
    emit(state.copyWith(status: TransactionFormStatus.loading));
    try {
      final products = await _repository.watchProducts().first;
      final locations = await _repository.watchLocations().first;
      final employees = await _repository.watchEmployees().first;

      emit(state.copyWith(
        status: TransactionFormStatus.idle,
        products: products,
        locations: locations,
        employees: employees,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: TransactionFormStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  void _onProductChanged(
    TransactionFormProductChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(productId: event.productId));
  }

  void _onSourceChanged(
    TransactionFormSourceChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(sourceLocationId: event.locationId));
  }

  void _onTargetChanged(
    TransactionFormTargetChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(targetLocationId: event.locationId));
  }

  void _onQuantityChanged(
    TransactionFormQuantityChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(quantity: event.quantity));
  }

  void _onTypeChanged(
    TransactionFormTypeChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(transactionType: event.transactionType));
  }

  void _onReferenceChanged(
    TransactionFormReferenceChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(reference: event.reference));
  }

  void _onNoteChanged(
    TransactionFormNoteChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(note: event.note));
  }

  void _onEmployeeChanged(
    TransactionFormEmployeeChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(employeeId: event.employeeId));
  }

  Future<void> _onSubmitted(
    TransactionFormSubmitted event,
    Emitter<TransactionFormState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: TransactionFormStatus.loading));

    try {
      final transaction = InventoryTransactionEntity(
        id: _uuid.v4(),
        productId: state.productId!,
        sourceLocationId: state.sourceLocationId,
        targetLocationId: state.targetLocationId,
        quantity: state.quantity,
        transactionType: state.transactionType,
        reference: state.reference,
        note: state.note,
        employeeId: state.employeeId,
        occurredAt: DateTime.now().toUtc(),
        sync: SyncMetadata(
          id: _uuid.v4(),
          updatedAt: DateTime.now().toUtc(),
          pendingSync: true,
        ),
      );

      await _repository.upsertTransaction(transaction);
      emit(state.copyWith(status: TransactionFormStatus.success));
    } catch (error) {
      emit(state.copyWith(
        status: TransactionFormStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }
}

