import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/product/product_form_event.dart';
import 'package:inventario_final/bloc/product/product_form_state.dart';
import 'package:inventario_final/data/repositories/auth_repository.dart';
import 'package:inventario_final/data/repositories/inventory_repository.dart';
import 'package:inventario_final/models/entities.dart';
import 'package:inventario_final/models/enums.dart';
import 'package:uuid/uuid.dart';

// Clase ProductFormBloc que sirve para manejar el estado de la forma de producto
// Se encarga de manejar el estado de la forma de producto y de las acciones de sincronización
// También se encarga de manejar el estado de la aplicación y de las acciones de sincronización
class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  ProductFormBloc({
    required InventoryRepository repository,
    required AuthRepository authRepository,
    required Uuid uuid,
  })  : _repository = repository,
        _authRepository = authRepository,
        _uuid = uuid,
        super(const ProductFormState()) {
    on<ProductFormInitialized>(_onInitialized);
    on<ProductFormNameChanged>(_onNameChanged);
    on<ProductFormSkuChanged>(_onSkuChanged);
    on<ProductFormCategoryChanged>(_onCategoryChanged);
    on<ProductFormUnitChanged>(_onUnitChanged);
    on<ProductFormPriceChanged>(_onPriceChanged);
    on<ProductFormLocationChanged>(_onLocationChanged);
    on<ProductFormInitialStockChanged>(_onInitialStockChanged);
    on<ProductFormImageChanged>(_onImageChanged);
    on<ProductFormActiveToggled>(_onActiveToggled);
    on<ProductFormSubmitted>(_onSubmitted);
  }

  final InventoryRepository _repository;
  final AuthRepository _authRepository;
  final Uuid _uuid;

  // Método para manejar el evento de inicialización
  Future<void> _onInitialized(
    ProductFormInitialized event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(status: ProductFormStatus.loading));
    
    try {
      // Cargar ubicaciones
      final locations = await _repository.getAllLocations();
      
      if (event.productId != null) {
        // Modo edición: cargar producto existente
        final product = await _repository.getProductById(event.productId!);
        if (product != null) {
          emit(state.copyWith(
            status: ProductFormStatus.initial,
            isEditing: true,
            productId: product.id,
            name: product.name,
            sku: product.sku,
            category: product.category,
            unit: product.unit,
            price: product.price.toString(),
            active: product.active,
            locations: locations,
          ));
        }
      } else {
        // Modo creación
        emit(state.copyWith(
          status: ProductFormStatus.initial,
          locations: locations,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ProductFormStatus.failure,
        errorMessage: 'Error al cargar datos: $e',
      ));
    }
  }

  // Método para manejar el evento de cambio de nombre
  void _onNameChanged(ProductFormNameChanged event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(name: event.name));
  }

  // Método para manejar el evento de cambio de SKU
  void _onSkuChanged(ProductFormSkuChanged event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(sku: event.sku));
  }

  // Método para manejar el evento de cambio de categoría
  void _onCategoryChanged(ProductFormCategoryChanged event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(category: event.category));
  }

  // Método para manejar el evento de cambio de unidad
  void _onUnitChanged(ProductFormUnitChanged event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(unit: event.unit));
  }

  // Método para manejar el evento de cambio de precio
  void _onPriceChanged(ProductFormPriceChanged event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(price: event.price));
  }

  // Método para manejar el evento de cambio de ubicación
  void _onLocationChanged(ProductFormLocationChanged event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(locationId: event.locationId));
  }

  // Método para manejar el evento de cambio de stock inicial
  void _onInitialStockChanged(ProductFormInitialStockChanged event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(initialStock: event.stock));
  }

  // Método para manejar el evento de cambio de imagen
  void _onImageChanged(ProductFormImageChanged event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(imagePath: event.imagePath));
  }

  // Método para manejar el evento de cambio de estado activo
  void _onActiveToggled(ProductFormActiveToggled event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(active: event.active));
  }

  // Método para manejar el evento de envío
  Future<void> _onSubmitted(
    ProductFormSubmitted event,
    Emitter<ProductFormState> emit,
  ) async {
    if (!state.isValid) {
      emit(state.copyWith(
        status: ProductFormStatus.failure,
        errorMessage: 'Por favor complete todos los campos requeridos',
      ));
      return;
    }

    emit(state.copyWith(status: ProductFormStatus.loading));

    try {
      final now = DateTime.now().toUtc();
      final productId = state.isEditing ? state.productId! : _uuid.v4();
      
      // Crear o actualizar producto
      final product = ProductEntity(
        id: productId,
        name: state.name.trim(),
        sku: state.sku.trim().toUpperCase(),
        category: state.category.trim(),
        unit: state.unit.trim(),
        price: double.parse(state.price),
        active: state.active,
        sync: SyncMetadata(
          id: productId,
          updatedAt: now,
          pendingSync: true,
        ),
      );

      await _repository.saveProduct(product);

      // Si es un producto nuevo, crear transacción inicial
      // El snapshot se creará automáticamente al guardar la transacción
      if (!state.isEditing && state.locationId != null && state.initialStock.isNotEmpty) {
        final initialStock = double.parse(state.initialStock);
        
        if (initialStock > 0) {
          // Obtener empleado actual para la transacción
          final currentEmployee = await _authRepository.currentUser();
          final employeeId = currentEmployee?.id ?? '';

          // Crear transacción de compra inicial
          // El método upsertTransaction automáticamente creará/actualizará el snapshot
          final transactionId = _uuid.v4();
          final transaction = InventoryTransactionEntity(
            id: transactionId,
            productId: productId,
            transactionType: TransactionType.purchase,
            quantity: initialStock,
            sourceLocationId: null,
            targetLocationId: state.locationId,
            reference: 'STOCK-INICIAL',
            note: 'Stock inicial del producto',
            employeeId: employeeId,
            occurredAt: now,
            sync: SyncMetadata(
              id: transactionId,
              updatedAt: now,
              pendingSync: true,
            ),
          );

          await _repository.saveTransaction(transaction);
        }
      }

      emit(state.copyWith(status: ProductFormStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: ProductFormStatus.failure,
        errorMessage: 'Error al guardar producto: $e',
      ));
    }
  }
}

