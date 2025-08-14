import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _paleBlue = Color(0xFFE6EEFA);
const Color _slateBlue = Color(0xFF6C7A9C);
const Color _lightGray = Color(0xFFE9E9EB);
const Color _vividBlue = Color(0xFF5790DF);
const Color _navyBlue = Color(0xFF093D89);

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
  cardTheme: CardThemeData(
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: lightColorScheme.primaryContainer, width: 1),
    ),
    color: Colors.white,
  ),
);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: _vividBlue,
  brightness: Brightness.light,
  primary: _vividBlue,
  secondary: _slateBlue,
  tertiary: _navyBlue,
  // Surface colors
  surface: _lightGray,
  onSurface: Colors.black87,
  inverseSurface: _navyBlue,
  // Special colors
  primaryContainer: _paleBlue,
  secondaryContainer: _lightGray.withValues(alpha: 0.5),
  tertiaryContainer: _navyBlue.withValues(alpha: 0.1),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: _storyTextTheme(ThemeData.dark()),
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
  seedColor: _vividBlue,
  brightness: Brightness.dark,
  primary: _vividBlue,
  secondary: const Color(0xFF8D9BB8),
  tertiary: const Color(0xFF3C6DB4),
  // Surface colors
  surface: const Color(0xFF121212),
  onSurface: Colors.white70,
  inverseSurface: const Color(0xFF3C6DB4),
  // Special colors
  primaryContainer: const Color(0xFF1A2D4D),
  secondaryContainer: const Color(0xFF2D3748),
  tertiaryContainer: Color(0xFF0E1A2D),
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
    GoogleFonts.interTextTheme(Theme.of(context).textTheme).copyWith(
      headlineLarge: GoogleFonts.playfairDisplay(),
      titleMedium: TextStyle(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _slateBlue,
      ),
      bodyLarge: TextStyle(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
        height: 1.5,
      ),
      labelSmall: TextStyle(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: _slateBlue,
      ),
    );
