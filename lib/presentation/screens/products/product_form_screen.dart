import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventario_final/bloc/product/product_form_bloc.dart';
import 'package:inventario_final/bloc/product/product_form_event.dart';
import 'package:inventario_final/bloc/product/product_form_state.dart';
import 'package:inventario_final/data/repositories/auth_repository.dart';
import 'package:inventario_final/data/repositories/inventory_repository.dart';
import 'package:uuid/uuid.dart';

class ProductFormScreen extends StatelessWidget {
  const ProductFormScreen({super.key, this.productId});

  static const routeName = '/products/form';
  final String? productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductFormBloc(
        repository: context.read<InventoryRepository>(),
        authRepository: context.read<AuthRepository>(),
        uuid: const Uuid(),
      )..add(ProductFormInitialized(productId: productId)),
      child: const _ProductFormView(),
    );
  }
}

class _ProductFormView extends StatelessWidget {
  const _ProductFormView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductFormBloc, ProductFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == ProductFormStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.isEditing
                  ? 'Producto actualizado correctamente'
                  : 'Producto creado correctamente'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(true);
        } else if (state.status == ProductFormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Error desconocido'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<ProductFormBloc, ProductFormState>(
            builder: (context, state) {
              return Text(state.isEditing ? 'Editar Producto' : 'Nuevo Producto');
            },
          ),
        ),
        body: const _ProductForm(),
      ),
    );
  }
}

class _ProductForm extends StatefulWidget {
  const _ProductForm();

  @override
  State<_ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<_ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  final List<String> _categories = [
    'Alfombras',
    'Piso Flotante',
    'Piso Pak',
    'Cielo Falso',
    'Viniles',
    'Decoración',
    'Otros',
  ];

  final List<String> _units = [
    'm²',
    'Unidad',
    'Rollo',
    'Caja',
    'Plancha',
    'Metro',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  bool _controllersInitialized = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFormBloc, ProductFormState>(
      builder: (context, state) {
        if (state.status == ProductFormStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Sincronizar controladores con el estado cuando carga un producto para editar (solo una vez)
        if (state.isEditing && state.name.isNotEmpty && !_controllersInitialized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_controllersInitialized) {
              _nameController.text = state.name;
              _skuController.text = state.sku;
              _priceController.text = state.price;
              _controllersInitialized = true;
            }
          });
        }

        return Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Imagen del producto (opcional)
              _buildImagePicker(context, state),
              const SizedBox(height: 24),

              // Nombre
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Producto *',
                  hintText: 'Ej: Alfombra Persa Premium',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory_2),
                ),
                textCapitalization: TextCapitalization.words,
                onChanged: (value) =>
                    context.read<ProductFormBloc>().add(ProductFormNameChanged(value)),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El nombre es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // SKU
              TextFormField(
                controller: _skuController,
                decoration: const InputDecoration(
                  labelText: 'SKU / Código *',
                  hintText: 'Ej: ALF-001',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.qr_code),
                ),
                textCapitalization: TextCapitalization.characters,
                onChanged: (value) =>
                    context.read<ProductFormBloc>().add(ProductFormSkuChanged(value)),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El SKU es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Categoría
              DropdownButtonFormField<String>(
                value: state.category.isEmpty ? null : state.category,
                decoration: const InputDecoration(
                  labelText: 'Categoría *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(value: category, child: Text(category));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<ProductFormBloc>().add(ProductFormCategoryChanged(value));
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La categoría es requerida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Unidad de medida
              DropdownButtonFormField<String>(
                value: state.unit.isEmpty ? null : state.unit,
                decoration: const InputDecoration(
                  labelText: 'Unidad de Medida *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.straighten),
                ),
                items: _units.map((unit) {
                  return DropdownMenuItem(value: unit, child: Text(unit));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<ProductFormBloc>().add(ProductFormUnitChanged(value));
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La unidad es requerida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Precio
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Precio *',
                  hintText: '0.00',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                  suffixText: 'S/',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                onChanged: (value) =>
                    context.read<ProductFormBloc>().add(ProductFormPriceChanged(value)),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El precio es requerido';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price < 0) {
                    return 'Ingrese un precio válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Estado activo/inactivo
              SwitchListTile(
                title: const Text('Producto Activo'),
                subtitle: Text(state.active ? 'Visible en el sistema' : 'Oculto'),
                value: state.active,
                onChanged: (value) {
                  context.read<ProductFormBloc>().add(ProductFormActiveToggled(value));
                },
              ),
              const SizedBox(height: 24),

              // Sección de inventario inicial (solo para productos nuevos)
              if (!state.isEditing) ...[
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  'Inventario Inicial',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                // Ubicación
                DropdownButtonFormField<String>(
                  value: state.locationId,
                  decoration: const InputDecoration(
                    labelText: 'Ubicación Inicial *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  items: state.locations.map((location) {
                    return DropdownMenuItem(
                      value: location.id,
                      child: Text(location.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    context.read<ProductFormBloc>().add(ProductFormLocationChanged(value));
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Seleccione una ubicación';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Stock inicial
                TextFormField(
                  controller: _stockController,
                  decoration: InputDecoration(
                    labelText: 'Cantidad Inicial *',
                    hintText: '0',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.inventory)
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  onChanged: (value) => context
                      .read<ProductFormBloc>()
                      .add(ProductFormInitialStockChanged(value)),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'La cantidad inicial es requerida';
                    }
                    final stock = double.tryParse(value);
                    if (stock == null || stock < 0) {
                      return 'Ingrese una cantidad válida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Se creará un registro de compra inicial con esta cantidad',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Debug info (temporal)
              if (!state.isValid) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber, color: Colors.orange.shade700, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Campos pendientes:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (state.name.isEmpty) const Text('• Nombre'),
                      if (state.sku.isEmpty) const Text('• SKU'),
                      if (state.category.isEmpty) const Text('• Categoría'),
                      if (state.unit.isEmpty) const Text('• Unidad'),
                      if (state.price.isEmpty) const Text('• Precio'),
                      if (!state.isEditing && state.locationId == null) const Text('• Ubicación'),
                      if (!state.isEditing && state.initialStock.isEmpty) const Text('• Stock Inicial'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Botón de guardar
              ElevatedButton.icon(
                onPressed: state.isValid
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ProductFormBloc>().add(const ProductFormSubmitted());
                        }
                      }
                    : null,
                icon: const Icon(Icons.save),
                label: Text(state.isEditing ? 'Actualizar Producto' : 'Crear Producto'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImagePicker(BuildContext context, ProductFormState state) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: state.imagePath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(state.imagePath!),
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(
                  Icons.image,
                  size: 64,
                  color: Colors.grey,
                ),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => _pickImage(context),
          icon: const Icon(Icons.photo_camera),
          label: const Text('Agregar Foto (Opcional)'),
        ),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (pickedFile != null && context.mounted) {
      context.read<ProductFormBloc>().add(ProductFormImageChanged(pickedFile.path));
    }
  }
}

