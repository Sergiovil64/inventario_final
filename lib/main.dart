import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inventario_final/bloc/app_bloc_observer.dart';
import 'package:inventario_final/bloc/authentication/authentication_bloc.dart';
import 'package:inventario_final/bloc/authentication/authentication_event.dart';
import 'package:inventario_final/bloc/authentication/authentication_state.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_bloc.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_event.dart';
import 'package:inventario_final/bloc/sync/sync_bloc.dart';
import 'package:inventario_final/bloc/sync/sync_event.dart';
import 'package:inventario_final/config/supabase_config.dart';
import 'package:inventario_final/data/local/local_data_source.dart';
import 'package:inventario_final/data/local/local_database.dart';
import 'package:inventario_final/data/remote/supabase_auth_service.dart';
import 'package:inventario_final/data/repositories/auth_repository.dart';
import 'package:inventario_final/data/repositories/inventory_repository.dart';
import 'package:inventario_final/presentation/router/app_router.dart';
import 'package:inventario_final/presentation/screens/dashboard/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await SupabaseConfig.initialize();
  Bloc.observer = const AppBlocObserver();
  final database = LocalDatabase();
  final localDataSource = LocalInventoryDataSource(database);
  final repository = InventoryRepository(localDataSource: localDataSource);

  final authRepository = AuthRepository(
    remoteService: SupabaseAuthService(),
    localDataSource: localDataSource,
  );

  runApp(MainApp(
    repository: repository,
    authRepository: authRepository,
    router: AppRouter(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.repository,
    required this.authRepository,
    required this.router,
  });

  final InventoryRepository repository;
  final AuthRepository authRepository;
  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: repository),
        RepositoryProvider.value(value: authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(repository: authRepository)
              ..add(const AuthenticationStarted()),
          ),
          BlocProvider(
            create: (context) => SyncBloc(repository: repository),
          ),
          BlocProvider(
            create: (context) => InventoryOverviewBloc(repository)
              ..add(const InventoryOverviewSubscriptionRequested()),
          ),
        ],
        child: _AppSyncListener(
          child: MaterialApp(
            title: 'Inventario Offline',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
              useMaterial3: true,
            ),
            onGenerateRoute: router.onGenerateRoute,
            initialRoute: DashboardScreen.routeName,
          ),
        ),
      ),
    );
  }
}

class _AppSyncListener extends StatelessWidget {
  const _AppSyncListener({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // Disparar sincronización cuando el usuario se autentica exitosamente
        if (state.status == AuthenticationStatus.authenticated) {
          context.read<SyncBloc>().add(const SyncRequested(force: true));
          
          // Inicializar la ubicación seleccionada con la ubicación del empleado
          if (state.user?.locationId != null && state.user!.locationId.isNotEmpty) {
            context.read<InventoryOverviewBloc>().add(
              InventoryOverviewLocationChanged(state.user!.locationId),
            );
          }
        }
      },
      child: child,
    );
  }
}
