import 'package:flutter/material.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/products/product_list_screen.dart';
import '../screens/transactions/new_transaction_screen.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProductListScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ProductListScreen());
      case NewTransactionScreen.routeName:
        return MaterialPageRoute(builder: (_) => const NewTransactionScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case DashboardScreen.routeName:
      default:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
    }
  }
}

