import 'package:equatable/equatable.dart';
import 'package:inventario_final/models/entities.dart';
import 'package:inventario_final/models/enums.dart';

enum TransactionFormStatus { idle, loading, success, failure }

// Clase TransactionFormState que sirve para manejar el estado de la forma de transacción
class TransactionFormState extends Equatable {
  const TransactionFormState({
    this.status = TransactionFormStatus.idle,
    this.products = const [],
    this.locations = const [],
    this.employees = const [],
    this.productId,
    this.sourceLocationId,
    this.targetLocationId,
    this.employeeId = 'system',
    this.transactionType = TransactionType.purchase,
    this.quantity = 0,
    this.reference = '',
    this.note = '',
    this.errorMessage,
  });

  final TransactionFormStatus status;
  final List<ProductEntity> products;
  final List<LocationEntity> locations;
  final List<EmployeeEntity> employees;
  final String? productId;
  final String? sourceLocationId;
  final String? targetLocationId;
  final String employeeId;
  final TransactionType transactionType;
  final double quantity;
  final String reference;
  final String note;
  final String? errorMessage;

  bool get isValid =>
      productId != null &&
      quantity > 0 &&
      (transactionType != TransactionType.transfer ||
          (sourceLocationId != null && targetLocationId != null && sourceLocationId != targetLocationId));

  TransactionFormState copyWith({
    TransactionFormStatus? status,
    List<ProductEntity>? products,
    List<LocationEntity>? locations,
    List<EmployeeEntity>? employees,
    String? productId,
    String? sourceLocationId,
    String? targetLocationId,
    String? employeeId,
    TransactionType? transactionType,
    double? quantity,
    String? reference,
    String? note,
    String? errorMessage,
  }) {
    return TransactionFormState(
      status: status ?? this.status,
      products: products ?? this.products,
      locations: locations ?? this.locations,
      employees: employees ?? this.employees,
      productId: productId ?? this.productId,
      sourceLocationId: sourceLocationId ?? this.sourceLocationId,
      targetLocationId: targetLocationId ?? this.targetLocationId,
      employeeId: employeeId ?? this.employeeId,
      transactionType: transactionType ?? this.transactionType,
      quantity: quantity ?? this.quantity,
      reference: reference ?? this.reference,
      note: note ?? this.note,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        locations,
        employees,
        productId,
        sourceLocationId,
        targetLocationId,
        employeeId,
        transactionType,
        quantity,
        reference,
        note,
        errorMessage,
      ];
}

