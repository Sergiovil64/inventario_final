import 'package:equatable/equatable.dart';
import 'package:inventario_final/models/entities.dart';

enum ReportsStatus { initial, loading, success, failure }

// Clase ReportsState que sirve para manejar el estado de los reportes
class ReportsState extends Equatable {
  const ReportsState({
    this.status = ReportsStatus.initial,
    this.salesTransactions = const [],
    this.purchaseTransactions = const [],
    this.transferTransactions = const [],
    this.dailySalesTransactions = const [],
    this.totalSales = 0.0,
    this.totalPurchases = 0.0,
    this.totalDailySales = 0.0,
    this.error,
    this.products = const [],
    this.locations = const [],
  });

  final ReportsStatus status;
  final List<InventoryTransactionEntity> salesTransactions;
  final List<InventoryTransactionEntity> purchaseTransactions;
  final List<InventoryTransactionEntity> transferTransactions;
  final List<InventoryTransactionEntity> dailySalesTransactions;
  final double totalSales;
  final double totalPurchases;
  final double totalDailySales;
  final String? error;
  final List<ProductEntity> products;
  final List<LocationEntity> locations;

  ReportsState copyWith({
    ReportsStatus? status,
    List<InventoryTransactionEntity>? salesTransactions,
    List<InventoryTransactionEntity>? purchaseTransactions,
    List<InventoryTransactionEntity>? transferTransactions,
    List<InventoryTransactionEntity>? dailySalesTransactions,
    double? totalSales,
    double? totalPurchases,
    double? totalDailySales,
    String? error,
    List<ProductEntity>? products,
    List<LocationEntity>? locations,
  }) {
    return ReportsState(
      status: status ?? this.status,
      salesTransactions: salesTransactions ?? this.salesTransactions,
      purchaseTransactions: purchaseTransactions ?? this.purchaseTransactions,
      transferTransactions: transferTransactions ?? this.transferTransactions,
      dailySalesTransactions: dailySalesTransactions ?? this.dailySalesTransactions,
      totalSales: totalSales ?? this.totalSales,
      totalPurchases: totalPurchases ?? this.totalPurchases,
      totalDailySales: totalDailySales ?? this.totalDailySales,
      error: error,
      products: products ?? this.products,
      locations: locations ?? this.locations,
    );
  }

  @override
  List<Object?> get props => [
        status,
        salesTransactions,
        purchaseTransactions,
        transferTransactions,
        dailySalesTransactions,
        totalSales,
        totalPurchases,
        totalDailySales,
        error,
        products,
        locations,
      ];
}

