import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:inventario_final/data/repositories/auth_repository.dart';
import 'package:inventario_final/data/repositories/inventory_repository.dart';
import 'package:inventario_final/models/entities.dart';
import 'package:inventario_final/bloc/inventory/transaction_form_event.dart';
import 'package:inventario_final/bloc/inventory/transaction_form_state.dart';

// Clase TransactionFormBloc que sirve para manejar el estado de la forma de transacción
// Se encarga de manejar el estado de la forma de transacción y de las acciones de sincronización
// También se encarga de manejar el estado de la aplicación y de las acciones de sincronización
class TransactionFormBloc extends Bloc<TransactionFormEvent, TransactionFormState> {
  TransactionFormBloc({
    required InventoryRepository repository,
    required AuthRepository authRepository,
    required Uuid uuid,
  })  : _repository = repository,
        _authRepository = authRepository,
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
  final AuthRepository _authRepository;
  final Uuid _uuid;

  // Método para manejar el evento de inicialización
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

  // Método para manejar el evento de cambio de producto
  void _onProductChanged(
    TransactionFormProductChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(productId: event.productId));
  }

  // Método para manejar el evento de cambio de ubicación de origen
  void _onSourceChanged(
    TransactionFormSourceChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(sourceLocationId: event.locationId));
  }

  // Método para manejar el evento de cambio de ubicación de destino
  void _onTargetChanged(
    TransactionFormTargetChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(targetLocationId: event.locationId));
  }

  // Método para manejar el evento de cambio de cantidad
  void _onQuantityChanged(
    TransactionFormQuantityChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(quantity: event.quantity));
  }

  // Método para manejar el evento de cambio de tipo de transacción
  void _onTypeChanged(
    TransactionFormTypeChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(transactionType: event.transactionType));
  }

  // Método para manejar el evento de cambio de referencia
  void _onReferenceChanged(
    TransactionFormReferenceChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(reference: event.reference));
  }

  // Método para manejar el evento de cambio de nota
  void _onNoteChanged(
    TransactionFormNoteChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(note: event.note));
  }

  // Método para manejar el evento de cambio de empleado
  void _onEmployeeChanged(
    TransactionFormEmployeeChanged event,
    Emitter<TransactionFormState> emit,
  ) {
    emit(state.copyWith(employeeId: event.employeeId));
  }

  // Método para manejar el evento de envío
  Future<void> _onSubmitted(
    TransactionFormSubmitted event,
    Emitter<TransactionFormState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: TransactionFormStatus.loading));

    try {
      // Obtener empleado actual automáticamente
      final currentEmployee = await _authRepository.currentUser();
      final employeeId = currentEmployee?.id ?? '';

      if (employeeId.isEmpty) {
        emit(state.copyWith(
          status: TransactionFormStatus.failure,
          errorMessage: 'No se pudo obtener el usuario autenticado',
        ));
        return;
      }

      final transaction = InventoryTransactionEntity(
        id: _uuid.v4(),
        productId: state.productId!,
        sourceLocationId: state.sourceLocationId,
        targetLocationId: state.targetLocationId,
        quantity: state.quantity,
        transactionType: state.transactionType,
        reference: state.reference,
        note: state.note,
        employeeId: employeeId, // Usa el empleado autenticado
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

