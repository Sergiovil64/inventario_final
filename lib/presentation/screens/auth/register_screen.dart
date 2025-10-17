import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/authentication/authentication_bloc.dart';
import '../../../bloc/authentication/authentication_event.dart';
import '../../../bloc/authentication/authentication_state.dart';
import '../../../bloc/inventory/inventory_overview_bloc.dart';
import '../../../bloc/inventory/inventory_overview_event.dart';
import '../../../bloc/inventory/inventory_overview_state.dart';
import '../../../data/repositories/inventory_repository.dart';
import '../../../models/enums.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String? _locationId;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));
    _animationController.forward();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    try {
      await context.read<InventoryRepository>().loadLocations();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudieron cargar las ubicaciones: $e'),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (state.status == AuthenticationStatus.failure && state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primaryContainer,
                theme.colorScheme.secondaryContainer,
                theme.colorScheme.tertiaryContainer,
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: BlocProvider(
                  create: (_) => InventoryOverviewBloc(context.read<InventoryRepository>())
                    ..add(const InventoryOverviewSubscriptionRequested()),
                  child: BlocBuilder<InventoryOverviewBloc, InventoryOverviewState>(
                    builder: (context, inventoryState) {
                      final locations = inventoryState.locations;

                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: size.width > 600 ? 500 : double.infinity,
                            ),
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      // Botón de volver
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: IconButton(
                                          icon: const Icon(Icons.arrow_back),
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                      ),
                                      // Logo/Icono
                                      Container(
                                        height: 70,
                                        width: 70,
                                        margin: const EdgeInsets.only(bottom: 16),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primaryContainer,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.person_add,
                                          size: 40,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                      // Título
                                      Text(
                                        'Crear cuenta',
                                        style: theme.textTheme.headlineMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.primary,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Completa tus datos para registrarte',
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 28),
                                      // Nombre
                                      TextFormField(
                                        controller: _firstNameController,
                                        textInputAction: TextInputAction.next,
                                        textCapitalization: TextCapitalization.words,
                                        decoration: InputDecoration(
                                          labelText: 'Nombre',
                                          hintText: 'Tu nombre',
                                          prefixIcon: Icon(
                                            Icons.person_outline,
                                            color: theme.colorScheme.primary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor: theme.colorScheme.surface,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Por favor ingresa tu nombre';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      // Apellido
                                      TextFormField(
                                        controller: _lastNameController,
                                        textInputAction: TextInputAction.next,
                                        textCapitalization: TextCapitalization.words,
                                        decoration: InputDecoration(
                                          labelText: 'Apellido',
                                          hintText: 'Tu apellido',
                                          prefixIcon: Icon(
                                            Icons.badge_outlined,
                                            color: theme.colorScheme.primary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor: theme.colorScheme.surface,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Por favor ingresa tu apellido';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      // Email
                                      TextFormField(
                                        controller: _emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: 'Correo electrónico',
                                          hintText: 'ejemplo@correo.com',
                                          prefixIcon: Icon(
                                            Icons.email_outlined,
                                            color: theme.colorScheme.primary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor: theme.colorScheme.surface,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Por favor ingresa tu correo';
                                          }
                                          if (!value.contains('@')) {
                                            return 'Ingresa un correo válido';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      // Contraseña
                                      TextFormField(
                                        controller: _passwordController,
                                        obscureText: _obscurePassword,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: 'Contraseña',
                                          hintText: '••••••••',
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                            color: theme.colorScheme.primary,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off_outlined,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword = !_obscurePassword;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor: theme.colorScheme.surface,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.length < 6) {
                                            return 'Mínimo 6 caracteres';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      // Confirmar contraseña
                                      TextFormField(
                                        controller: _confirmPasswordController,
                                        obscureText: _obscureConfirmPassword,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: 'Confirmar contraseña',
                                          hintText: '••••••••',
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                            color: theme.colorScheme.primary,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureConfirmPassword
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off_outlined,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureConfirmPassword = !_obscureConfirmPassword;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor: theme.colorScheme.surface,
                                        ),
                                        validator: (value) {
                                          if (value != _passwordController.text) {
                                            return 'Las contraseñas no coinciden';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      // Ubicación
                                      DropdownButtonFormField<String>(
                                        value: _locationId,
                                        decoration: InputDecoration(
                                          labelText: 'Ubicación de trabajo',
                                          hintText: 'Selecciona una ubicación',
                                          prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color: theme.colorScheme.primary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor: theme.colorScheme.surface,
                                        ),
                                        items: locations.map((location) {
                                          return DropdownMenuItem<String>(
                                            value: location.id,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  location.type == LocationType.store
                                                      ? Icons.store
                                                      : Icons.warehouse,
                                                  size: 18,
                                                  color: theme.colorScheme.primary,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(location.name),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) => setState(() => _locationId = value),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Selecciona una ubicación';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 28),
                                      // Botón de registro
                                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                                        builder: (context, state) {
                                          final isLoading = state.status == AuthenticationStatus.loading;
                                          return FilledButton(
                                            onPressed: isLoading ? null : _handleRegister,
                                            style: FilledButton.styleFrom(
                                              padding: const EdgeInsets.symmetric(vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: isLoading
                                                ? const SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : const Text(
                                                    'Crear Cuenta',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthenticationBloc>().add(
            AuthenticationRegisterRequested(
              email: _emailController.text.trim(),
              password: _passwordController.text,
              firstName: _firstNameController.text.trim(),
              lastName: _lastNameController.text.trim(),
              locationId: _locationId!,
            ),
          );
    }
  }
}

