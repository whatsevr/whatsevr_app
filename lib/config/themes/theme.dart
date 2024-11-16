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
  Color get buttonColor; // rename from 'button' to 'buttonColor'
  Color get card;
  Color get icon;
  Color get shadow;
  Color get appBar;
  Color get success;
  Color get warning;
  Color get info;
  Color get lightBackground;
  Color get darkBackground;

  // Gradient colors
  List<Color> get primaryGradient => [primary, primary.withOpacity(0.7)];
  List<Color> get secondaryGradient => [secondary, secondary.withOpacity(0.7)];
  List<Color> get accentGradient => [accent, accent.withOpacity(0.7)];
  List<Color> get darkGradient => [buttonColor, buttonColor.withOpacity(0.7)];
  // Opacity constants
  double get dialogBarrierOpacity => 0.3;
  double get disabledOpacity => 0.38;
  double get hoverOpacity => 0.08;
  double get focusOpacity => 0.12;
  double get selectedOpacity => 0.16;

  // Elevation constants
  double get elevationSmall => 2;
  double get elevationMedium => 4;
  double get elevationLarge => 8;

  // Common properties
  double get spacing1 => 8;
  double get spacing2 => 16;
  double get spacing3 => 24;
  double get spacing4 => 32;
  double get spacing5 => 40;
  double get spacing6 => 48;
  double get borderRadius => 8;
  double get buttonHeight => 48;

  EdgeInsets get padding => EdgeInsets.all(spacing2);
  EdgeInsets get margin => EdgeInsets.all(spacing2);

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

  TextStyle get subtitle => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: text,
        height: 1.3,
      );

  TextStyle get caption => TextStyle(
        fontSize: 12,
        color: textLight,
        height: 1.4,
      );

  TextStyle get buttonText => TextStyle( // rename from 'buttonStyle' to 'buttonText'
        fontSize: 16,
        fontWeight: FontWeight.w600, // make slightly bolder
        color: surface, // should use surface color since buttons usually have primary background
        letterSpacing: 0.5,
        height: 1.0, // add height for better vertical alignment
      );

  // Border styles
  BorderRadius get borderRadiusSmall => BorderRadius.circular(4);
  BorderRadius get borderRadiusLarge => BorderRadius.circular(12);
  BorderRadius get borderRadiusFull => BorderRadius.circular(999);

  Border get border => Border.all(color: divider, width: 1);
  BoxShadow get boxShadow => BoxShadow(
        color: shadow,
        blurRadius: 8,
        offset: const Offset(0, 2),
      );

  // Card theme
  CardTheme get cardTheme => CardTheme(
        elevation: elevationSmall,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        color: card,
        margin: EdgeInsets.zero,
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
  Color get primary => const Color(0xFF2D3436);  // Dark gray with slight blue tint

  @override
  Color get secondary => const Color(0xFF636E72);  // Medium gray

  @override
  Color get background => Colors.white;

  @override
  Color get surface => const Color(0xFFFAFAFA);  // Very light gray

  @override
  Color get error => const Color(0xFFE53935);  // Vibrant red

  @override
  Color get text => const Color(0xFF2D3436);

  @override
  Color get textLight => const Color(0xFF636E72);

  @override
  Color get divider => const Color(0xFFDFE6E9);  // Light blue-gray

  @override
  Color get disabled => const Color(0xFFB2BEC3);  // Muted blue-gray

  @override
  Color get accent => const Color(0xFF0984E3);  // Bright blue

  @override
  Color get buttonColor => const Color(0xFF2D3436);

  @override
  Color get card => Colors.white;

  @override
  Color get icon => const Color(0xFF2D3436);
 
  @override
  Color get shadow => const Color(0xFF2D3436).withOpacity(0.1);

  @override
  Color get appBar => Colors.white;

  @override
  Color get success => const Color(0xFF00B894);  // Mint green

  @override
  Color get warning => const Color(0xFFFAB1A0);  // Soft coral

  @override
  Color get info => const Color(0xFF0984E3);  // Bright blue

  @override
  Color get lightBackground => Colors.white;

  @override
  Color get darkBackground => const Color(0xFFF5F6FA);  // Light grayish
}

class DarkTheme extends AppTheme {
  @override
  Color get primary => const Color(0xFFFDFDFD);  // Almost white

  @override
  Color get secondary => const Color(0xFFDFE6E9);  // Light gray

  @override
  Color get background => const Color(0xFF17181A);  // Very dark gray

  @override
  Color get surface => const Color(0xFF222427);  // Dark gray with slight warmth

  @override
  Color get error => const Color(0xFFFF7675);  // Soft red

  @override
  Color get text => const Color(0xFFFDFDFD);

  @override
  Color get textLight => const Color(0xFFB2BEC3);

  @override
  Color get divider => const Color(0xFF2D3436).withOpacity(0.5);

  @override
  Color get disabled => const Color(0xFF636E72);

  @override
  Color get accent => const Color(0xFF74B9FF);  // Light blue

  @override
  Color get buttonColor => const Color(0xFFFDFDFD);

  @override
  Color get card => const Color(0xFF222427);

  @override
  Color get icon => const Color(0xFFFDFDFD);

  @override
  Color get shadow => Colors.black.withOpacity(0.3);

  @override
  Color get appBar => const Color(0xFF222427);

  @override
  Color get success => const Color(0xFF55EFC4);  // Bright mint

  @override
  Color get warning => const Color(0xFFFFB8B8);  // Light coral

  @override
  Color get info => const Color(0xFF74B9FF);  // Light blue

  @override
  Color get lightBackground => const Color(0xFF222427);

  @override
  Color get darkBackground => const Color(0xFF17181A);

  @override
  BoxShadow get boxShadow => BoxShadow(
        color: shadow,
        blurRadius: 12,
        offset: const Offset(0, 4),
      );
}

// lib/theme/extensions/theme_extension.dart

extension ThemeBlocXtn on BuildContext {
  ThemeBloc get themeBloc => read<ThemeBloc>();
  void toggleTheme() => read<ThemeBloc>().add(ToggleThemeEvent());
  AppTheme get whatsevrTheme => read<ThemeBloc>().currentTheme;
  bool get isDarkMode => read<ThemeBloc>().state.themeType == ThemeType.dark;
}
