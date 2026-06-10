import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../providers/sticker_provider.dart';
import '../../widgets/main_navigation.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    final colorScheme = Theme.of(context).colorScheme;

    if (user != null) {
      Future.microtask(() {
        ref.read(stickerProvider.notifier).loadStickers();
      });
      return const MainNavigation();
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Logo ──────────────────────────────────────────────────
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sports_soccer,
                        size: 72,
                        color: colorScheme.primary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: colorScheme.secondary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.star_rounded,
                        size: 20,
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // ── Nombre de la app ──────────────────────────────────────
                Text(
                  'FIGURITAS_APP',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ÁLBUM MUNDIAL',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        letterSpacing: 5,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),

                const SizedBox(height: 12),

                // ── Subtítulo ─────────────────────────────────────────────
                Text(
                  'Colecciona, controla y completa\ntu álbum mundial.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                ),

                const SizedBox(height: 20),

                // ── Feature chips ─────────────────────────────────────────
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _FeatureChip(
                      icon: Icons.style_rounded,
                      label: '387 figuritas',
                      colorScheme: colorScheme,
                    ),
                    _FeatureChip(
                      icon: Icons.emoji_events_rounded,
                      label: 'Premios',
                      colorScheme: colorScheme,
                    ),
                    _FeatureChip(
                      icon: Icons.bar_chart_rounded,
                      label: 'Estadísticas',
                      colorScheme: colorScheme,
                    ),
                    _FeatureChip(
                      icon: Icons.cloud_done_rounded,
                      label: 'Online',
                      colorScheme: colorScheme,
                    ),
                  ],
                ),

                const SizedBox(height: 48),

                // ── Botón Google ──────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _loading
                        ? null
                        : () async {
                            setState(() => _loading = true);
                            await ref
                                .read(authProvider.notifier)
                                .signInWithGoogle();
                            if (mounted) setState(() => _loading = false);
                          },
                    icon: _loading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: colorScheme.onPrimary,
                            ),
                          )
                        : const Icon(Icons.login_rounded),
                    label: Text(
                      _loading ? 'Ingresando...' : 'Ingresar con Google',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      disabledBackgroundColor:
                          colorScheme.primary.withOpacity(0.6),
                      disabledForegroundColor:
                          colorScheme.onPrimary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Nota de sincronización ────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sync_rounded,
                      size: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Sincroniza tu progreso en todos tus dispositivos.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Widget auxiliar para los chips de features ────────────────────────────────

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({
    required this.icon,
    required this.label,
    required this.colorScheme,
  });

  final IconData icon;
  final String label;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colorScheme.onSecondaryContainer),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}