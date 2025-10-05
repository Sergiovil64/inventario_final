import 'package:equatable/equatable.dart';
import 'package:inventario_final/models/entities.dart';

enum ProductFormStatus { initial, loading, success, failure }

class ProductFormState extends Equatable {
  const ProductFormState({
    this.status = ProductFormStatus.initial,
    this.name = '',
    this.sku = '',
    this.category = '',
    this.unit = '',
    this.price = '',
    this.active = true,
    this.locationId,
    this.initialStock = '',
    this.imagePath,
    this.locations = const [],
    this.errorMessage,
    this.isEditing = false,
    this.productId,
  });

  final ProductFormStatus status;
  final String name;
  final String sku;
  final String category;
  final String unit;
  final String price;
  final bool active;
  final String? locationId;
  final String initialStock;
  final String? imagePath;
  final List<LocationEntity> locations;
  final String? errorMessage;
  final bool isEditing;
  final String? productId;

  bool get isValid =>
      name.isNotEmpty &&
      sku.isNotEmpty &&
      category.isNotEmpty &&
      unit.isNotEmpty &&
      price.isNotEmpty &&
      _isPriceValid &&
      (isEditing || (locationId != null && initialStock.isNotEmpty && _isStockValid));

  bool get _isPriceValid {
    final parsed = double.tryParse(price);
    return parsed != null && parsed >= 0;
  }

  bool get _isStockValid {
    final parsed = double.tryParse(initialStock);
    return parsed != null && parsed >= 0;
  }

  ProductFormState copyWith({
    ProductFormStatus? status,
    String? name,
    String? sku,
    String? category,
    String? unit,
    String? price,
    bool? active,
    String? locationId,
    String? initialStock,
    String? imagePath,
    List<LocationEntity>? locations,
    String? errorMessage,
    bool? isEditing,
    String? productId,
  }) {
    return ProductFormState(
      status: status ?? this.status,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      active: active ?? this.active,
      locationId: locationId ?? this.locationId,
      initialStock: initialStock ?? this.initialStock,
      imagePath: imagePath ?? this.imagePath,
      locations: locations ?? this.locations,
      errorMessage: errorMessage ?? this.errorMessage,
      isEditing: isEditing ?? this.isEditing,
      productId: productId ?? this.productId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        sku,
        category,
        unit,
        price,
        active,
        locationId,
        initialStock,
        imagePath,
        locations,
        errorMessage,
        isEditing,
        productId,
      ];
}

