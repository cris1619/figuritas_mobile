import 'package:flutter/material.dart';

class AppColors {

  static bool isDark(BuildContext context) {

    return Theme.of(context).brightness ==
        Brightness.dark;
  }

  static Color textPrimary(BuildContext context) {

    return isDark(context)
        ? Colors.white
        : const Color(0xFF0F172A);
  }

  static Color textSecondary(BuildContext context) {

    return isDark(context)
        ? Colors.white70
        : Colors.black87;
  }

  static Color textMuted(BuildContext context) {

    return isDark(context)
        ? Colors.white54
        : Colors.black54;
  }

  static Color card(BuildContext context) {

    return isDark(context)
        ? const Color(0xFF1E293B)
        : Colors.white;
  }

  static Color stickerInactive(
      BuildContext context) {

    return isDark(context)
        ? const Color(0xFF1E293B)
        : const Color(0xFFF1F5F9);
  }

  static Color progressBackground(
      BuildContext context) {

    return isDark(context)
        ? Colors.white12
        : Colors.black12;
  }

  static Color iconColor(BuildContext context) {

    return isDark(context)
        ? Colors.white70
        : Colors.black87;
  }
}