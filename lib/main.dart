import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'providers/theme_provider.dart';
import 'screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: FiguritasApp()));
}

class FiguritasApp extends ConsumerWidget {
  const FiguritasApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'FIGURITAS_APP',

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: themeMode,

      home: const LoginScreen(),
    );
  }
}
