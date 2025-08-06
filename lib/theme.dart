import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: _storyTextTheme(ThemeData.light()),
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.surface,
    foregroundColor: lightColorScheme.onSurface,
    elevation: 0,
    centerTitle: true,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lightColorScheme.surface,
    selectedItemColor: lightColorScheme.primary,
    unselectedItemColor: lightColorScheme.onSurface.withValues(alpha: 0.6),
  ),
);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF6D4C41),
  brightness: Brightness.light,
  secondary: const Color(0xFF8D6E63),
  tertiary: const Color(0xFF3E2723),
  // Surface colors
  surface: const Color(0xFFFFF8F5),
  onSurface: const Color(0xFF3E2723),
  inverseSurface: const Color(0xFF3E2723),
  // Special colors
  primaryContainer: const Color(0xFFD7CCC8),
  secondaryContainer: const Color(0xFFBCAAA4),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: _storyTextTheme(ThemeData.light()),
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
    elevation: 0,
    centerTitle: true,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkColorScheme.surface,
    selectedItemColor: darkColorScheme.primary,
    unselectedItemColor: darkColorScheme.onSurface.withValues(alpha: 0.6),
  ),
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF8D6E63),
  brightness: Brightness.dark,
  secondary: const Color(0xFFA1887F),
  tertiary: const Color(0xFFD7CCC8),
  // Surface colors
  surface: const Color(0xFF1A120F),
  onSurface: const Color(0xFFEFEBE9),
  inverseSurface: const Color(0xFFEFEBE9),
  // Special colors
  primaryContainer: const Color(0xFF4E342E),
  secondaryContainer: const Color(0xFF5D4037),
);

TextTheme _storyTextTheme(ThemeData base) {
  return base.textTheme
      .copyWith(
        displayLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.3,
          letterSpacing: -0.5,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          height: 1.6,
          letterSpacing: 0.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
          letterSpacing: 0.25,
        ),
      )
      .apply(
        displayColor: base.colorScheme.onSurface,
        bodyColor: base.colorScheme.onSurface,
      );
}

baseTextTheme(BuildContext context, ThemeData theme) =>
    GoogleFonts.loraTextTheme(
      Theme.of(context).textTheme,
    ).copyWith(headlineLarge: GoogleFonts.playfairDisplay());
