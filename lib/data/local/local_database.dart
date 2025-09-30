import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';


part 'local_database.g.dart';

class ProductRows extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get sku => text()();
  TextColumn get category => text()();
  TextColumn get unit => text()();
  RealColumn get price => real()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocationRows extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get address => text()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class EmployeeRows extends Table {
  TextColumn get id => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get email => text()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  TextColumn get locationId => text().references(LocationRows, #id)();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class InventorySnapshotRows extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text().references(ProductRows, #id)();
  TextColumn get locationId => text().references(LocationRows, #id)();
  RealColumn get quantity => real()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class InventoryTransactionRows extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text().references(ProductRows, #id)();
  @ReferenceName('sourceTransactions')
  TextColumn get sourceLocationId => text().nullable().references(LocationRows, #id)();
  @ReferenceName('targetTransactions')
  TextColumn get targetLocationId => text().nullable().references(LocationRows, #id)();
  RealColumn get quantity => real()();
  TextColumn get transactionType => text()();
  TextColumn get reference => text()();
  TextColumn get note => text().nullable()();
  TextColumn get employeeId => text().references(EmployeeRows, #id)();
  DateTimeColumn get occurredAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncStatuses extends Table {
  TextColumn get resource => text()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {resource};
}

@DriftDatabase(tables: [
  ProductRows,
  LocationRows,
  EmployeeRows,
  InventorySnapshotRows,
  InventoryTransactionRows,
  SyncStatuses,
])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'inventory.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

