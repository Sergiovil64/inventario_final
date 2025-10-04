import 'package:inventario_final/data/local/local_data_source.dart';
import 'package:inventario_final/data/remote/supabase_auth_service.dart';
import 'package:inventario_final/data/remote/supabase_inventory_service.dart';
import 'package:inventario_final/models/entities.dart';

class AuthRepository {
  AuthRepository({
    required SupabaseAuthService remoteService,
    required LocalInventoryDataSource localDataSource,
    SupabaseInventoryService? inventoryService,
  })  : _remote = remoteService,
        _local = localDataSource,
        _inventoryService = inventoryService ?? SupabaseInventoryService();

  final SupabaseAuthService _remote;
  final LocalInventoryDataSource _local;
  final SupabaseInventoryService _inventoryService;

  Future<EmployeeEntity?> currentUser() async {
    final session = _remote.currentSession();
    final user = session?.user;
    if (user == null) {
      return null;
    }
    final employees = await _local.getEmployees();
    return employees.firstWhere(
      (employee) => employee.email == user.email,
      orElse: () => EmployeeEntity(
        id: user.id,
        firstName: user.userMetadata?['first_name'] ?? '',
        lastName: user.userMetadata?['last_name'] ?? '',
        email: user.email ?? '',
        active: true,
        locationId: '',
        sync: SyncMetadata(
          id: user.id,
          updatedAt: DateTime.now().toUtc(),
          pendingSync: false,
        ),
      ),
    );
  }

  Future<EmployeeEntity> signIn(String email, String password) async {
    final session = await _remote.signIn(email, password);
    final user = session.user;
    if (user == null) {
      throw Exception('No se pudo obtener el usuario de Supabase.');
    }
    final employees = await _local.getEmployees();
    return employees.firstWhere(
      (employee) => employee.email == email,
      orElse: () => EmployeeEntity(
        id: user.id,
        firstName: user.userMetadata?['first_name'] ?? '',
        lastName: user.userMetadata?['last_name'] ?? '',
        email: email,
        active: true,
        locationId: '',
        sync: SyncMetadata(
          id: user.id,
          updatedAt: DateTime.now().toUtc(),
          pendingSync: false,
        ),
      ),
    );
  }

  Future<EmployeeEntity> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String locationId,
  }) async {
    final response = await _remote.signUp(
      email: email,
      password: password,
      data: {
        'first_name': firstName,
        'last_name': lastName,
      },
    );

    final user = response.user;
    if (user == null) {
      throw Exception('No se pudo registrar el usuario en Supabase.');
    }

    final now = DateTime.now().toUtc();
    final employee = EmployeeEntity(
      id: user.id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      active: true,
      locationId: locationId,
      sync: SyncMetadata(
        id: user.id,
        updatedAt: now,
        pendingSync: false,
      ),
    );

    // Insertar en Supabase primero
    try {
      final syncedEmployees = await _inventoryService.upsertEmployees([employee]);
      final syncedEmployee = syncedEmployees.isNotEmpty ? syncedEmployees.first : employee;
      
      // Luego guardar en local con los datos sincronizados
      await _local.upsertEmployee(syncedEmployee);
      return syncedEmployee;
    } catch (e) {
      // Si falla la inserción en Supabase, guardar localmente con pendingSync
      final pendingEmployee = employee.copyWith(
        sync: employee.sync.copyWith(pendingSync: true),
      );
      await _local.upsertEmployee(pendingEmployee);
      return pendingEmployee;
    }
  }

  Future<void> signOut() => _remote.signOut();
}

