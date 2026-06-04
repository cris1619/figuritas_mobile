import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'widgets/main_navigation.dart';

void main() {

  runApp(

    const ProviderScope(
      child: AlbumMundialApp(),
    ),
  );
}

class AlbumMundialApp extends ConsumerWidget {

  const AlbumMundialApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final themeMode =
        ref.watch(themeProvider);

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Álbum Mundial',

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: themeMode,

      home: const MainNavigation(),
    );
  }
}