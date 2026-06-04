import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {

  return ThemeNotifier();

});

class ThemeNotifier extends StateNotifier<ThemeMode> {

  ThemeNotifier() : super(ThemeMode.dark) {
    loadTheme();
  }

  static const storageKey = 'theme_mode';

  Future<void> loadTheme() async {

    final prefs = await SharedPreferences.getInstance();

    final isDark =
        prefs.getBool(storageKey) ?? true;

    state =
        isDark
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  Future<void> toggleTheme() async {

    final prefs = await SharedPreferences.getInstance();

    if (state == ThemeMode.dark) {

      state = ThemeMode.light;

      await prefs.setBool(storageKey, false);

    } else {

      state = ThemeMode.dark;

      await prefs.setBool(storageKey, true);
    }
  }
}