import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/main_navigation.dart';
import '../../providers/sticker_provider.dart';

class LoginScreen extends ConsumerWidget {

  const LoginScreen({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref) {

    final user =
        ref.watch(authProvider);

    if (user != null) {

  Future.microtask(() {

    ref
        .read(
            stickerProvider.notifier)
        .loadStickers();
  });

  return const MainNavigation();
}

    return Scaffold(

      body: Center(

        child: Padding(

          padding:
              const EdgeInsets.all(30),

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.sports_soccer,
                size: 100,
                color: Colors.green,
              ),

              const SizedBox(height: 30),

              const Text(

                "FIGURITAS_APP",

                style: TextStyle(
                  fontSize: 34,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Guarda tu progreso online",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              ElevatedButton.icon(

                onPressed: () {

                  ref
                      .read(authProvider
                          .notifier)
                      .signInWithGoogle();
                },

                icon:
                    const Icon(Icons.login),

                label: const Text(
                  "Ingresar con Google",
                ),

                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}