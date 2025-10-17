import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/reports/reports_event.dart';
import 'package:inventario_final/bloc/reports/reports_state.dart';
import 'package:inventario_final/data/repositories/inventory_repository.dart';
import 'package:inventario_final/models/entities.dart';
import 'package:inventario_final/models/enums.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc({
    required InventoryRepository inventoryRepository,
  })  : _inventoryRepository = inventoryRepository,
        super(const ReportsState()) {
    on<LoadSalesAndPurchasesReport>(_onLoadSalesAndPurchasesReport);
    on<LoadTransfersReport>(_onLoadTransfersReport);
    on<LoadDailySalesReport>(_onLoadDailySalesReport);
    on<ResetReports>(_onResetReports);
  }

  final InventoryRepository _inventoryRepository;

  Future<void> _onLoadSalesAndPurchasesReport(
    LoadSalesAndPurchasesReport event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(status: ReportsStatus.loading));

    try {
      // Cargar productos y locaciones si no están disponibles
      var products = state.products;
      var locations = state.locations;
      if (products.isEmpty || locations.isEmpty) {
        products = await _inventoryRepository.getProducts();
        locations = await _inventoryRepository.getAllLocations();
      }

      final transactions = await _inventoryRepository.getTransactionsByDateRange(
        startDate: event.startDate,
        endDate: event.endDate,
        locationId: event.locationId,
      );

      final salesTransactions = transactions
          .where((t) => t.transactionType == TransactionType.sale)
          .toList();

      final purchaseTransactions = transactions
          .where((t) => t.transactionType == TransactionType.purchase)
          .toList();

      // Calcular totales basados en precio del producto y cantidad
      final now = DateTime.now();
      final emptyProduct = ProductEntity(
        id: '',
        name: '',
        sku: '',
        category: '',
        unit: '',
        price: 0.0,
        active: false,
        sync: SyncMetadata(
          id: '',
          updatedAt: now,
          pendingSync: false,
        ),
      );

      double totalSales = 0.0;
      for (var transaction in salesTransactions) {
        final product = products.firstWhere(
          (p) => p.id == transaction.productId,
          orElse: () => emptyProduct,
        );
        totalSales += product.price * transaction.quantity;
      }

      double totalPurchases = 0.0;
      for (var transaction in purchaseTransactions) {
        final product = products.firstWhere(
          (p) => p.id == transaction.productId,
          orElse: () => emptyProduct,
        );
        totalPurchases += product.price * transaction.quantity;
      }

      emit(state.copyWith(
        status: ReportsStatus.success,
        salesTransactions: salesTransactions,
        purchaseTransactions: purchaseTransactions,
        totalSales: totalSales,
        totalPurchases: totalPurchases,
        products: products,
        locations: locations,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ReportsStatus.failure,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadTransfersReport(
    LoadTransfersReport event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(status: ReportsStatus.loading));

    try {
      // Cargar productos y locaciones si no están disponibles
      var products = state.products;
      var locations = state.locations;
      if (products.isEmpty || locations.isEmpty) {
        products = await _inventoryRepository.getProducts();
        locations = await _inventoryRepository.getAllLocations();
      }

      final transactions = await _inventoryRepository.getTransactionsByDateRange(
        startDate: event.startDate,
        endDate: event.endDate,
      );

      var transferTransactions = transactions
          .where((t) => t.transactionType == TransactionType.transfer)
          .toList();

      // Filtrar por ubicaciones si se especifican
      if (event.sourceLocationId != null) {
        transferTransactions = transferTransactions
            .where((t) => t.sourceLocationId == event.sourceLocationId)
            .toList();
      }

      if (event.targetLocationId != null) {
        transferTransactions = transferTransactions
            .where((t) => t.targetLocationId == event.targetLocationId)
            .toList();
      }

      emit(state.copyWith(
        status: ReportsStatus.success,
        transferTransactions: transferTransactions,
        products: products,
        locations: locations,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ReportsStatus.failure,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadDailySalesReport(
    LoadDailySalesReport event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(status: ReportsStatus.loading));

    try {
      // Cargar productos y locaciones si no están disponibles
      var products = state.products;
      var locations = state.locations;
      if (products.isEmpty || locations.isEmpty) {
        products = await _inventoryRepository.getProducts();
        locations = await _inventoryRepository.getAllLocations();
      }

      final startOfDay = DateTime(event.date.year, event.date.month, event.date.day);
      final endOfDay = DateTime(event.date.year, event.date.month, event.date.day, 23, 59, 59);

      final transactions = await _inventoryRepository.getTransactionsByDateRange(
        startDate: startOfDay,
        endDate: endOfDay,
      );

      final dailySalesTransactions = transactions
          .where((t) => t.transactionType == TransactionType.sale)
          .toList();

      // Calcular total de ventas del día
      final now = DateTime.now();
      final emptyProduct = ProductEntity(
        id: '',
        name: '',
        sku: '',
        category: '',
        unit: '',
        price: 0.0,
        active: false,
        sync: SyncMetadata(
          id: '',
          updatedAt: now,
          pendingSync: false,
        ),
      );

      double totalDailySales = 0.0;
      for (var transaction in dailySalesTransactions) {
        final product = products.firstWhere(
          (p) => p.id == transaction.productId,
          orElse: () => emptyProduct,
        );
        totalDailySales += product.price * transaction.quantity;
      }

      emit(state.copyWith(
        status: ReportsStatus.success,
        dailySalesTransactions: dailySalesTransactions,
        totalDailySales: totalDailySales,
        products: products,
        locations: locations,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ReportsStatus.failure,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onResetReports(
    ResetReports event,
    Emitter<ReportsState> emit,
  ) async {
    emit(ReportsState(
      products: state.products,
      locations: state.locations,
    ));
  }
}

