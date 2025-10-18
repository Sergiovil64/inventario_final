import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventario_final/bloc/reports/reports_bloc.dart';
import 'package:inventario_final/bloc/reports/reports_event.dart';
import 'package:inventario_final/bloc/reports/reports_state.dart';
import 'package:inventario_final/models/entities.dart';
import 'package:inventario_final/models/enums.dart';
import 'package:inventario_final/data/repositories/inventory_repository.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  static const String routeName = '/reports';

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsBloc(
        inventoryRepository: context.read<InventoryRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reportes'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Ventas/Compras'),
              Tab(text: 'Transferencias'),
              Tab(text: 'Ventas del Día'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            _SalesAndPurchasesTab(),
            _TransfersTab(),
            _DailySalesTab(),
          ],
        ),
      ),
    );
  }
}

// Tab 1: Reportes de Ventas y Compras
class _SalesAndPurchasesTab extends StatefulWidget {
  const _SalesAndPurchasesTab();

  @override
  State<_SalesAndPurchasesTab> createState() => _SalesAndPurchasesTabState();
}

class _SalesAndPurchasesTabState extends State<_SalesAndPurchasesTab> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  String? _selectedLocationId;

  void _loadReport() {
    context.read<ReportsBloc>().add(
          LoadSalesAndPurchasesReport(
            startDate: _startDate,
            endDate: _endDate,
            locationId: _selectedLocationId,
          ),
        );
  }

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        return Column(
          children: [
            // Filtros
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Filtros',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _selectStartDate,
                            icon: const Icon(Icons.calendar_today),
                            label: Text(
                              'Desde: ${DateFormat('dd/MM/yyyy').format(_startDate)}',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _selectEndDate,
                            icon: const Icon(Icons.calendar_today),
                            label: Text(
                              'Hasta: ${DateFormat('dd/MM/yyyy').format(_endDate)}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String?>(
                      value: _selectedLocationId,
                      decoration: const InputDecoration(
                        labelText: 'Tienda/Almacén',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('Todas las ubicaciones'),
                        ),
                        ...state.locations.map(
                          (location) => DropdownMenuItem<String?>(
                            value: location.id,
                            child: Text(
                              '${location.name} (${location.type == LocationType.store ? 'Tienda' : 'Almacén'})',
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedLocationId = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _loadReport,
                      icon: const Icon(Icons.search),
                      label: const Text('Generar Reporte'),
                    ),
                  ],
                ),
              ),
            ),
            // Resultados
            Expanded(
              child: _buildReportResults(state),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReportResults(ReportsState state) {
    if (state.status == ReportsStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == ReportsStatus.failure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: ${state.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadReport,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (state.status == ReportsStatus.initial) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Selecciona los filtros y genera un reporte',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // Mostrar resultados
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Resumen
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Total Ventas',
                  amount: state.totalSales,
                  icon: Icons.trending_up,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _SummaryCard(
                  title: 'Total Compras',
                  amount: state.totalPurchases,
                  icon: Icons.shopping_cart,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Ventas
          _TransactionSection(
            title: 'Ventas (${state.salesTransactions.length})',
            transactions: state.salesTransactions,
            products: state.products,
            locations: state.locations,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          // Compras
          _TransactionSection(
            title: 'Compras (${state.purchaseTransactions.length})',
            transactions: state.purchaseTransactions,
            products: state.products,
            locations: state.locations,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

// Tab 2: Reportes de Transferencias
class _TransfersTab extends StatefulWidget {
  const _TransfersTab();

  @override
  State<_TransfersTab> createState() => _TransfersTabState();
}

class _TransfersTabState extends State<_TransfersTab> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  String? _sourceLocationId;
  String? _targetLocationId;

  void _loadReport() {
    context.read<ReportsBloc>().add(
          LoadTransfersReport(
            startDate: _startDate,
            endDate: _endDate,
            sourceLocationId: _sourceLocationId,
            targetLocationId: _targetLocationId,
          ),
        );
  }

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        return Column(
          children: [
            // Filtros
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Filtros',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _selectStartDate,
                            icon: const Icon(Icons.calendar_today),
                            label: Text(
                              'Desde: ${DateFormat('dd/MM/yyyy').format(_startDate)}',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _selectEndDate,
                            icon: const Icon(Icons.calendar_today),
                            label: Text(
                              'Hasta: ${DateFormat('dd/MM/yyyy').format(_endDate)}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String?>(
                      value: _sourceLocationId,
                      decoration: const InputDecoration(
                        labelText: 'Ubicación Origen',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('Todas'),
                        ),
                        ...state.locations.map(
                          (location) => DropdownMenuItem<String?>(
                            value: location.id,
                            child: Text(
                              '${location.name} (${location.type == LocationType.store ? 'Tienda' : 'Almacén'})',
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _sourceLocationId = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String?>(
                      value: _targetLocationId,
                      decoration: const InputDecoration(
                        labelText: 'Ubicación Destino',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('Todas'),
                        ),
                        ...state.locations.map(
                          (location) => DropdownMenuItem<String?>(
                            value: location.id,
                            child: Text(
                              '${location.name} (${location.type == LocationType.store ? 'Tienda' : 'Almacén'})',
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _targetLocationId = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _loadReport,
                      icon: const Icon(Icons.search),
                      label: const Text('Generar Reporte'),
                    ),
                  ],
                ),
              ),
            ),
            // Resultados
            Expanded(
              child: _buildReportResults(state),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReportResults(ReportsState state) {
    if (state.status == ReportsStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == ReportsStatus.failure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: ${state.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadReport,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (state.status == ReportsStatus.initial) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.swap_horiz, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Selecciona los filtros y genera un reporte',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // Mostrar resultados
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TransactionSection(
            title: 'Transferencias (${state.transferTransactions.length})',
            transactions: state.transferTransactions,
            products: state.products,
            locations: state.locations,
            color: Colors.orange,
            showBothLocations: true,
          ),
        ],
      ),
    );
  }
}

// Tab 3: Ventas del Día
class _DailySalesTab extends StatefulWidget {
  const _DailySalesTab();

  @override
  State<_DailySalesTab> createState() => _DailySalesTabState();
}

class _DailySalesTabState extends State<_DailySalesTab> {
  DateTime _selectedDate = DateTime.now();

  void _loadReport() {
    context.read<ReportsBloc>().add(
          LoadDailySalesReport(date: _selectedDate),
        );
  }

  @override
  void initState() {
    super.initState();
    // Cargar automáticamente el reporte del día actual
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadReport();
    });
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _loadReport();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        return Column(
          children: [
            // Selector de fecha
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Seleccionar Fecha',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: _selectDate,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        'Fecha: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Resultados
            Expanded(
              child: _buildReportResults(state),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReportResults(ReportsState state) {
    if (state.status == ReportsStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == ReportsStatus.failure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: ${state.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadReport,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    // Mostrar resultados
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Resumen destacado
          Card(
            color: Colors.green.shade50,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.attach_money,
                    size: 64,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Venta Global del Día',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${state.totalDailySales.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${state.dailySalesTransactions.length} transacciones',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Detalle de transacciones
          _TransactionSection(
            title: 'Detalle de Ventas',
            transactions: state.dailySalesTransactions,
            products: state.products,
            locations: state.locations,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

// Widget para mostrar tarjetas de resumen
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  final String title;
  final double amount;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para mostrar sección de transacciones
class _TransactionSection extends StatelessWidget {
  const _TransactionSection({
    required this.title,
    required this.transactions,
    required this.products,
    required this.locations,
    required this.color,
    this.showBothLocations = false,
  });

  final String title;
  final List<InventoryTransactionEntity> transactions;
  final List<ProductEntity> products;
  final List<LocationEntity> locations;
  final Color color;
  final bool showBothLocations;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.inbox_outlined, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 8),
              Text(
                'No hay transacciones',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...transactions.map((transaction) {
          final now = DateTime.now();
          final product = products.firstWhere(
            (p) => p.id == transaction.productId,
            orElse: () => ProductEntity(
              id: '',
              name: 'Producto no encontrado',
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
            ),
          );

          final sourceLocation = transaction.sourceLocationId != null
              ? locations.firstWhere(
                  (l) => l.id == transaction.sourceLocationId,
                  orElse: () => LocationEntity(
                    id: '',
                    name: 'N/A',
                    type: LocationType.store,
                    address: '',
                    sync: SyncMetadata(
                      id: '',
                      updatedAt: now,
                      pendingSync: false,
                    ),
                  ),
                )
              : null;

          final targetLocation = transaction.targetLocationId != null
              ? locations.firstWhere(
                  (l) => l.id == transaction.targetLocationId,
                  orElse: () => LocationEntity(
                    id: '',
                    name: 'N/A',
                    type: LocationType.store,
                    address: '',
                    sync: SyncMetadata(
                      id: '',
                      updatedAt: now,
                      pendingSync: false,
                    ),
                  ),
                )
              : null;

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.2),
                child: Icon(
                  _getIconForTransactionType(transaction.transactionType),
                  color: color,
                ),
              ),
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cantidad: ${transaction.quantity} ${product.unit}'),
                  Text(
                    'Fecha: ${DateFormat('dd/MM/yyyy HH:mm').format(transaction.occurredAt)}',
                  ),
                  if (showBothLocations) ...[
                    if (sourceLocation != null)
                      Text('Origen: ${sourceLocation.name}'),
                    if (targetLocation != null)
                      Text('Destino: ${targetLocation.name}'),
                  ] else ...[
                    if (sourceLocation != null)
                      Text('Ubicación: ${sourceLocation.name}'),
                    if (targetLocation != null)
                      Text('Ubicación: ${targetLocation.name}'),
                  ],
                  if (transaction.note != null && transaction.note!.isNotEmpty)
                    Text(
                      'Nota: ${transaction.note}',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                ],
              ),
              trailing: Text(
                '\$${(product.price * transaction.quantity).toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  IconData _getIconForTransactionType(TransactionType type) {
    switch (type) {
      case TransactionType.sale:
        return Icons.shopping_cart;
      case TransactionType.purchase:
        return Icons.add_shopping_cart;
      case TransactionType.transfer:
        return Icons.swap_horiz;
      case TransactionType.adjustment:
        return Icons.edit;
    }
  }
}

