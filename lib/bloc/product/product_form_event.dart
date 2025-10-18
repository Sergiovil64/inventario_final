import 'package:equatable/equatable.dart';

// Clase ProductFormEvent que sirve para manejar los eventos de la forma de producto
abstract class ProductFormEvent extends Equatable {
  const ProductFormEvent();

  @override
  List<Object?> get props => [];
}

class ProductFormInitialized extends ProductFormEvent {
  const ProductFormInitialized({this.productId});

  final String? productId;

  @override
  List<Object?> get props => [productId];
}

class ProductFormNameChanged extends ProductFormEvent {
  const ProductFormNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class ProductFormSkuChanged extends ProductFormEvent {
  const ProductFormSkuChanged(this.sku);

  final String sku;

  @override
  List<Object> get props => [sku];
}

class ProductFormCategoryChanged extends ProductFormEvent {
  const ProductFormCategoryChanged(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}

class ProductFormUnitChanged extends ProductFormEvent {
  const ProductFormUnitChanged(this.unit);

  final String unit;

  @override
  List<Object> get props => [unit];
}

class ProductFormPriceChanged extends ProductFormEvent {
  const ProductFormPriceChanged(this.price);

  final String price;

  @override
  List<Object> get props => [price];
}

class ProductFormLocationChanged extends ProductFormEvent {
  const ProductFormLocationChanged(this.locationId);

  final String? locationId;

  @override
  List<Object?> get props => [locationId];
}

class ProductFormInitialStockChanged extends ProductFormEvent {
  const ProductFormInitialStockChanged(this.stock);

  final String stock;

  @override
  List<Object> get props => [stock];
}

class ProductFormImageChanged extends ProductFormEvent {
  const ProductFormImageChanged(this.imagePath);

  final String? imagePath;

  @override
  List<Object?> get props => [imagePath];
}

class ProductFormSubmitted extends ProductFormEvent {
  const ProductFormSubmitted();
}

class ProductFormActiveToggled extends ProductFormEvent {
  const ProductFormActiveToggled(this.active);

  final bool active;

  @override
  List<Object> get props => [active];
}

