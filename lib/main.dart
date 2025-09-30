import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_bloc_observer.dart';
import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/sync/sync_bloc.dart';
import 'config/supabase_config.dart';
import 'data/local/local_data_source.dart';
import 'data/local/local_database.dart';
import 'data/remote/supabase_auth_service.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/inventory_repository.dart';
import 'presentation/router/app_router.dart';
import 'presentation/screens/dashboard/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            create: (context) => SyncBloc(repository: repository)
              ..add(const SyncRequested(force: true)),
          ),
        ],
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
    );
  }
}
