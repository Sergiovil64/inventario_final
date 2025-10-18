import 'package:flutter/material.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/products/product_form_screen.dart';
import '../screens/products/product_list_screen.dart';
import '../screens/reports/reports_screen.dart';
import '../screens/transactions/new_transaction_screen.dart';

// Clase AppRouter que sirve para manejar el router de la aplicación
class AppRouter {
  // Método para generar la ruta de la aplicación
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProductListScreen.routeName:
        // Ruta para la lista de productos
        return MaterialPageRoute(builder: (_) => const ProductListScreen());
      case ProductFormScreen.routeName:
        // Ruta para la forma de producto
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ProductFormScreen(
            productId: args?['productId'] as String?,
          ),
        );
      case NewTransactionScreen.routeName:
        // Ruta para la nueva transacción
        return MaterialPageRoute(builder: (_) => const NewTransactionScreen());
      case ReportsScreen.routeName:
        // Ruta para los reportes
        return MaterialPageRoute(builder: (_) => const ReportsScreen());
      case LoginScreen.routeName:
        // Ruta para el login
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RegisterScreen.routeName:
        // Ruta para el registro
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case DashboardScreen.routeName:
      default:
        // Ruta por defecto
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
    }
  }
}

