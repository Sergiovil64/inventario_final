enum LocationType {
  store,
  warehouse,
}

extension LocationTypeX on LocationType {
  String get value {
    switch (this) {
      case LocationType.store:
        return 'store';
      case LocationType.warehouse:
        return 'warehouse';
    }
  }

  static LocationType fromValue(String value) {
    switch (value) {
      case 'store':
        return LocationType.store;
      case 'warehouse':
        return LocationType.warehouse;
      default:
        throw ArgumentError('Unknown LocationType value: $value');
    }
  }
}

enum TransactionType {
  purchase,
  sale,
  transfer,
  adjustment,
}

extension TransactionTypeX on TransactionType {
  String get value {
    switch (this) {
      case TransactionType.purchase:
        return 'purchase';
      case TransactionType.sale:
        return 'sale';
      case TransactionType.transfer:
        return 'transfer';
      case TransactionType.adjustment:
        return 'adjustment';
    }
  }

  static TransactionType fromValue(String value) {
    switch (value) {
      case 'purchase':
        return TransactionType.purchase;
      case 'sale':
        return TransactionType.sale;
      case 'transfer':
        return TransactionType.transfer;
      case 'adjustment':
        return TransactionType.adjustment;
      default:
        throw ArgumentError('Unknown TransactionType value: $value');
    }
  }
}

enum SyncResource {
  products,
  locations,
  employees,
  inventorySnapshots,
  inventoryTransactions,
}

extension SyncResourceX on SyncResource {
  String get value {
    switch (this) {
      case SyncResource.products:
        return 'products';
      case SyncResource.locations:
        return 'locations';
      case SyncResource.employees:
        return 'employees';
      case SyncResource.inventorySnapshots:
        return 'inventory_snapshots';
      case SyncResource.inventoryTransactions:
        return 'inventory_transactions';
    }
  }

  static SyncResource fromValue(String value) {
    switch (value) {
      case 'products':
        return SyncResource.products;
      case 'locations':
        return SyncResource.locations;
      case 'employees':
        return SyncResource.employees;
      case 'inventory_snapshots':
        return SyncResource.inventorySnapshots;
      case 'inventory_transactions':
        return SyncResource.inventoryTransactions;
      default:
        throw ArgumentError('Unknown SyncResource value: $value');
    }
  }
}

