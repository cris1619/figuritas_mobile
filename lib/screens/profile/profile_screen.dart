import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref) {

    final user =
        FirebaseAuth.instance
            .currentUser;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Perfil"),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(24),

        child: Column(

          children: [

            const SizedBox(height: 30),

            CircleAvatar(

              radius: 60,

              backgroundImage:

                  user?.photoURL != null

                      ? NetworkImage(
                          user!.photoURL!)
                      : null,

              child:

                  user?.photoURL == null

                      ? const Icon(
                          Icons.person,
                          size: 60,
                        )

                      : null,
            ),

            const SizedBox(height: 24),

            Text(

              user?.displayName ??
                  "Usuario",

              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
                color:
                    AppColors
                        .textPrimary(
                            context),
              ),
            ),

            const SizedBox(height: 10),

            Text(

              user?.email ?? "",

              style: TextStyle(
                fontSize: 16,
                color:
                    AppColors
                        .textSecondary(
                            context),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                onPressed: () async {

                  await ref
                      .read(authProvider
                          .notifier)
                      .logout();
                },

                icon:
                    const Icon(Icons.logout),

                label:
                    const Text(
                        "Cerrar sesión"),

                style:
                    ElevatedButton
                        .styleFrom(

                  padding:
                      const EdgeInsets
                          .all(18),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}