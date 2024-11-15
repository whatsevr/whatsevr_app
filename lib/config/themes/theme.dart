import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsevr_app/config/themes/bloc/theme_bloc.dart';

enum ThemeType { light, dark }

abstract class AppTheme {
  // Abstract color properties
  Color get primary;
  Color get secondary;
  Color get background;
  Color get surface;
  Color get error;
  Color get text;
  Color get textLight;
  Color get divider;
  Color get disabled;
  Color get accent;
  Color get button;
  Color get card;
  Color get icon;
  Color get shadow;
  Color get appBar;

  // Common properties
  double get spacing1 => 8;
  double get spacing2 => 16;
  double get spacing3 => 24;
  double get borderRadius => 8;
  double get buttonHeight => 48;

  TextStyle get h1 => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: text,
        height: 1.2,
      );

  TextStyle get h2 => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: text,
        height: 1.2,
      );

  TextStyle get h3 => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: text,
        height: 1.2,
      );

  TextStyle get body => TextStyle(
        fontSize: 16,
        color: text,
        height: 1.5,
      );

  TextStyle get bodySmall => TextStyle(
        fontSize: 14,
        color: text,
        height: 1.5,
      );

  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: divider),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: error),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
}

class LightTheme extends AppTheme {
  @override
  Color get primary => const Color(0xFF2196F3);

  @override
  Color get secondary => const Color(0xFF00BCD4);

  @override
  Color get background => const Color(0xFFF5F5F5);

  @override
  Color get surface => Colors.white;

  @override
  Color get error => const Color(0xFFB00020);

  @override
  Color get text => const Color(0xFF1A1A1A);

  @override
  Color get textLight => text.withOpacity(0.6);

  @override
  Color get divider => const Color(0xFFE0E0E0);

  @override
  Color get disabled => const Color(0xFFBDBDBD);

  @override
  Color get accent => const Color(0xFFFFC107);

  @override
  Color get button => const Color(0xFF2196F3);

  @override
  Color get card => Colors.white;

  @override
  Color get icon => const Color(0xFF1A1A1A);

  @override
  Color get shadow => Colors.black.withOpacity(0.2);

  @override
  Color get appBar => const Color(0xFF2196F3);
}

class DarkTheme extends AppTheme {
  @override
  Color get primary => const Color(0xFF90CAF9);

  @override
  Color get secondary => const Color(0xFF80DEEA);

  @override
  Color get background => const Color(0xFF121212);

  @override
  Color get surface => const Color(0xFF1E1E1E);

  @override
  Color get error => const Color(0xFFCF6679);

  @override
  Color get text => Colors.white;

  @override
  Color get textLight => text.withOpacity(0.6);

  @override
  Color get divider => const Color(0xFF424242);

  @override
  Color get disabled => const Color(0xFF757575);

  @override
  Color get accent => const Color(0xFFFFC107);

  @override
  Color get button => const Color(0xFF90CAF9);

  @override
  Color get card => const Color(0xFF1E1E1E);

  @override
  Color get icon => Colors.white;

  @override
  Color get shadow => Colors.black.withOpacity(0.7);

  @override
  Color get appBar => const Color(0xFF1E1E1E);
}

// lib/theme/extensions/theme_extension.dart

extension ThemeBlocXtn on BuildContext {
  ThemeBloc get themeBloc => read<ThemeBloc>();
  void toggleTheme() => read<ThemeBloc>().add(ToggleThemeEvent());
  AppTheme get whatsevrTheme => read<ThemeBloc>().currentTheme;
  bool get isDarkMode => read<ThemeBloc>().state.themeType == ThemeType.dark;
}
