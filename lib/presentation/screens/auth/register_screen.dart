import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/authentication/authentication_bloc.dart';
import '../../../bloc/authentication/authentication_event.dart';
import '../../../bloc/authentication/authentication_state.dart';
import '../../../bloc/inventory/inventory_overview_bloc.dart';
import '../../../bloc/inventory/inventory_overview_event.dart';
import '../../../bloc/inventory/inventory_overview_state.dart';
import '../../../data/repositories/inventory_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String? _locationId;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    try {
      await context.read<InventoryRepository>().loadLocations();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudieron cargar las ubicaciones: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar usuario')),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            Navigator.pop(context);
          } else if (state.status == AuthenticationStatus.failure && state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        child: BlocProvider(
          create: (_) => InventoryOverviewBloc(context.read<InventoryRepository>())
            ..add(const InventoryOverviewSubscriptionRequested()),
          child: BlocBuilder<InventoryOverviewBloc, InventoryOverviewState>(
            builder: (context, inventoryState) {
              final locations = inventoryState.locations;

              return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(labelText: 'Nombre'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingresa el nombre';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(labelText: 'Apellido'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingresa el apellido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(labelText: 'Correo electrónico'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingresa el correo';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(labelText: 'Contraseña'),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'La contraseña debe tener al menos 6 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: _locationId,
                          decoration: const InputDecoration(labelText: 'Ubicación'),
                          items: locations
                              .map(
                                (location) => DropdownMenuItem<String>(
                                  value: location.id,
                                  child: Text(location.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) => setState(() => _locationId = value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Selecciona una ubicación';
                            }
                            return null;
                          },
                        ),
                          const SizedBox(height: 24),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              final isLoading = state.status == AuthenticationStatus.loading;
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          if (_formKey.currentState?.validate() ?? false) {
                                            context.read<AuthenticationBloc>().add(
                                                  AuthenticationRegisterRequested(
                                                    email: _emailController.text,
                                                    password: _passwordController.text,
                                                    firstName: _firstNameController.text,
                                                    lastName: _lastNameController.text,
                                                    locationId: _locationId!,
                                                  ),
                                                );
                                          }
                                        },
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : const Text('Registrar'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

