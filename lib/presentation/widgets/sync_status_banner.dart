import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sync/sync_bloc.dart';

class SyncStatusBanner extends StatelessWidget {
  const SyncStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SyncBloc, SyncState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SyncStatus.success && state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
          context.read<SyncBloc>().add(const SyncStatusResetRequested());
        } else if (state.status == SyncStatus.failure && state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        }
      },
      builder: (context, state) {
        if (!state.isOnline) {
          return _StatusCard(
            color: Colors.orange,
            icon: Icons.wifi_off,
            message: 'Sin conexión. Guardando localmente...',
            action: TextButton(
              onPressed: () => context.read<SyncBloc>().add(const SyncRequested()),
              child: const Text('Reintentar'),
            ),
          );
        }

        if (state.status == SyncStatus.inProgress) {
          return const _StatusCard(
            color: Colors.blue,
            icon: Icons.sync,
            message: 'Sincronizando inventario... Mantén la aplicación abierta.',
          );
        }
        if (state.status == SyncStatus.failure) {
          return _StatusCard(
            color: Colors.red,
            icon: Icons.error_outline,
            message: state.message ?? 'Error al sincronizar',
            action: TextButton(
              onPressed: () => context.read<SyncBloc>().add(const SyncRequested()),
              child: const Text('Reintentar'),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.color,
    required this.icon,
    required this.message,
    this.action,
  });

  final Color color;
  final IconData icon;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withValues(alpha: 0.15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}

