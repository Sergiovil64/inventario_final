import '../local/local_data_source.dart';
import '../remote/supabase_auth_service.dart';
import '../../models/entities.dart';

class AuthRepository {
  AuthRepository({
    required SupabaseAuthService remoteService,
    required LocalInventoryDataSource localDataSource,
  })  : _remote = remoteService,
        _local = localDataSource;

  final SupabaseAuthService _remote;
  final LocalInventoryDataSource _local;

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

  Future<void> signOut() => _remote.signOut();
}

