import 'package:equatable/equatable.dart';
import 'package:inventario_final/models/enums.dart';

abstract class TransactionFormEvent extends Equatable {
  const TransactionFormEvent();

  @override
  List<Object?> get props => [];
}

class TransactionFormInitialized extends TransactionFormEvent {
  const TransactionFormInitialized();
}

class TransactionFormProductChanged extends TransactionFormEvent {
  const TransactionFormProductChanged(this.productId);

  final String? productId;

  @override
  List<Object?> get props => [productId];
}

class TransactionFormSourceChanged extends TransactionFormEvent {
  const TransactionFormSourceChanged(this.locationId);

  final String? locationId;

  @override
  List<Object?> get props => [locationId];
}

class TransactionFormTargetChanged extends TransactionFormEvent {
  const TransactionFormTargetChanged(this.locationId);

  final String? locationId;

  @override
  List<Object?> get props => [locationId];
}

class TransactionFormQuantityChanged extends TransactionFormEvent {
  const TransactionFormQuantityChanged(this.quantity);

  final double quantity;

  @override
  List<Object?> get props => [quantity];
}

class TransactionFormTypeChanged extends TransactionFormEvent {
  const TransactionFormTypeChanged(this.transactionType);

  final TransactionType transactionType;

  @override
  List<Object?> get props => [transactionType];
}

class TransactionFormReferenceChanged extends TransactionFormEvent {
  const TransactionFormReferenceChanged(this.reference);

  final String reference;

  @override
  List<Object?> get props => [reference];
}

class TransactionFormNoteChanged extends TransactionFormEvent {
  const TransactionFormNoteChanged(this.note);

  final String note;

  @override
  List<Object?> get props => [note];
}

class TransactionFormEmployeeChanged extends TransactionFormEvent {
  const TransactionFormEmployeeChanged(this.employeeId);

  final String employeeId;

  @override
  List<Object?> get props => [employeeId];
}

class TransactionFormSubmitted extends TransactionFormEvent {
  const TransactionFormSubmitted();
}

