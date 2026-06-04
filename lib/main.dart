import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'widgets/main_navigation.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AlbumMundialApp(),
    ),
  );
}

class AlbumMundialApp extends StatelessWidget {
  const AlbumMundialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Álbum Mundial',
      theme: AppTheme.darkTheme,
      home: const MainNavigation(),
    );
  }
}