import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// App theme utility that provides Material 3 compliant themes
/// with consistent typography, colors, and component styles.
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();
  
  /// Light color scheme - following Material 3 guidelines
  static final ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: const Color(0xFF2A3D45),      // Deep teal
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFFCFD8DD),  // Light teal
    onPrimaryContainer: const Color(0xFF1A2C34),
    secondary: const Color(0xFFD8B08C),    // Warm sand
    onSecondary: Colors.black,
    secondaryContainer: const Color(0xFFF2E6D9),  // Light sand
    onSecondaryContainer: const Color(0xFF5D4A35),
    tertiary: const Color(0xFFAF9164),     // Taupe
    onTertiary: Colors.white,
    tertiaryContainer: const Color(0xFFEBE2D1),  // Light taupe
    onTertiaryContainer: const Color(0xFF4A3D2A),
    error: const Color(0xFFCF5C60),        // Muted red
    onError: Colors.white,
    errorContainer: const Color(0xFFF9DCDC),  // Light red
    onErrorContainer: const Color(0xFF5C2728),
    background: const Color(0xFFF5F5F5),   // Off-white
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    surfaceVariant: const Color(0xFFEEEFF0),  // Light grey
    onSurfaceVariant: const Color(0xFF494D50),
    outline: const Color(0xFFADB0B2),      // Medium grey
    shadow: Colors.black.withOpacity(0.1),
    inverseSurface: const Color(0xFF1F2A30),
    onInverseSurface: Colors.white,
    inversePrimary: const Color(0xFFAFBEC6),
    surfaceTint: const Color(0xFF2A3D45).withOpacity(0.05),
  );

  /// Dark color scheme - following Material 3 guidelines
  static final ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: const Color(0xFF91A4AD),      // Light teal
    onPrimary: const Color(0xFF1A2C34),
    primaryContainer: const Color(0xFF3A4D55),  // Medium teal
    onPrimaryContainer: const Color(0xFFCFD8DD),
    secondary: const Color(0xFFE6CAA7),    // Light sand
    onSecondary: const Color(0xFF453A29),
    secondaryContainer: const Color(0xFF725C45),  // Medium sand
    onSecondaryContainer: const Color(0xFFF2E6D9),
    tertiary: const Color(0xFFCFB78A),     // Light taupe
    onTertiary: const Color(0xFF4A3D2A),
    tertiaryContainer: const Color(0xFF7D6C4A),  // Medium taupe
    onTertiaryContainer: const Color(0xFFEBE2D1),
    error: const Color(0xFFE89294),        // Light red
    onError: const Color(0xFF5C2728),
    errorContainer: const Color(0xFF8C4143),  // Medium red
    onErrorContainer: const Color(0xFFF9DCDC),
    background: const Color(0xFF121212),   // Dark grey
    onBackground: Colors.white,
    surface: const Color(0xFF1E1E1E),      // Near black
    onSurface: Colors.white,
    surfaceVariant: const Color(0xFF292D30),  // Medium-dark grey
    onSurfaceVariant: const Color(0xFFD5D8DA),
    outline: const Color(0xFF8A8D8F),      // Medium-light grey
    shadow: Colors.black.withOpacity(0.2),
    inverseSurface: const Color(0xFFE6E6E6),
    onInverseSurface: Colors.black,
    inversePrimary: const Color(0xFF2A3D45),
    surfaceTint: const Color(0xFF91A4AD).withOpacity(0.1),
  );

  /// Material 3 typography scale
  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      height: 1.12,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.16,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.22,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.29,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.33,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      height: 1.27,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.5,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.33,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.45,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.43,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
    ),
  );

  /// Light theme - Material 3
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      // Card Theme
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: _lightColorScheme.primary,
        titleTextStyle: _textTheme.titleLarge?.copyWith(
          color: _lightColorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
      ),
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: _lightColorScheme.primary,
        unselectedItemColor: _lightColorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showUnselectedLabels: true,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      ),
      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _lightColorScheme.primary,
        foregroundColor: _lightColorScheme.onPrimary,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightColorScheme.primary,
          foregroundColor: _lightColorScheme.onPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: _textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _lightColorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: _textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _lightColorScheme.surfaceVariant.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _lightColorScheme.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _lightColorScheme.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _lightColorScheme.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: _textTheme.bodyMedium?.copyWith(
          color: _lightColorScheme.onSurfaceVariant.withOpacity(0.7),
        ),
        labelStyle: _textTheme.bodyMedium?.copyWith(
          color: _lightColorScheme.onSurfaceVariant,
        ),
      ),
      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: _lightColorScheme.primary,
        unselectedLabelColor: _lightColorScheme.onSurfaceVariant,
        labelStyle: _textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: _textTheme.titleSmall,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: _lightColorScheme.primary, width: 2),
        ),
      ),
      // Dialog Theme
      dialogTheme: DialogTheme(
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Colors.white,
        titleTextStyle: _textTheme.headlineSmall?.copyWith(
          color: _lightColorScheme.onSurface,
        ),
        contentTextStyle: _textTheme.bodyMedium?.copyWith(
          color: _lightColorScheme.onSurfaceVariant,
        ),
      ),
      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: _lightColorScheme.primary,
        inactiveTrackColor: _lightColorScheme.surfaceVariant,
        thumbColor: _lightColorScheme.primary,
        overlayColor: _lightColorScheme.primary.withOpacity(0.2),
        trackHeight: 4.0,
      ),
      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return _lightColorScheme.surfaceVariant.withOpacity(0.5);
            }
            if (states.contains(MaterialState.selected)) {
              return _lightColorScheme.primary;
            }
            return _lightColorScheme.surfaceVariant;
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      // Divider Theme
      dividerTheme: DividerThemeData(
        color: _lightColorScheme.outline.withOpacity(0.5),
        thickness: 1,
        space: 1,
      ),
      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _lightColorScheme.inverseSurface,
        contentTextStyle: _textTheme.bodyMedium?.copyWith(
          color: _lightColorScheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 6,
      ),
    );
  }

  /// Dark theme - Material 3
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      // Card Theme
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: _darkColorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: _darkColorScheme.surface,
        foregroundColor: _darkColorScheme.primary,
        titleTextStyle: _textTheme.titleLarge?.copyWith(
          color: _darkColorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
      ),
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _darkColorScheme.surface,
        selectedItemColor: _darkColorScheme.primary,
        unselectedItemColor: _darkColorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showUnselectedLabels: true,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      ),
      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _darkColorScheme.primary,
        foregroundColor: _darkColorScheme.onPrimary,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkColorScheme.primary,
          foregroundColor: _darkColorScheme.onPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: _textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _darkColorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: _textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkColorScheme.surfaceVariant.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _darkColorScheme.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _darkColorScheme.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _darkColorScheme.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: _textTheme.bodyMedium?.copyWith(
          color: _darkColorScheme.onSurfaceVariant.withOpacity(0.7),
        ),
        labelStyle: _textTheme.bodyMedium?.copyWith(
          color: _darkColorScheme.onSurfaceVariant,
        ),
      ),
      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: _darkColorScheme.primary,
        unselectedLabelColor: _darkColorScheme.onSurfaceVariant,
        labelStyle: _textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: _textTheme.titleSmall,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: _darkColorScheme.primary, width: 2),
        ),
      ),
      // Dialog Theme
      dialogTheme: DialogTheme(
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: _darkColorScheme.surface,
        titleTextStyle: _textTheme.headlineSmall?.copyWith(
          color: _darkColorScheme.onSurface,
        ),
        contentTextStyle: _textTheme.bodyMedium?.copyWith(
          color: _darkColorScheme.onSurfaceVariant,
        ),
      ),
      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: _darkColorScheme.primary,
        inactiveTrackColor: _darkColorScheme.surfaceVariant,
        thumbColor: _darkColorScheme.primary,
        overlayColor: _darkColorScheme.primary.withOpacity(0.2),
        trackHeight: 4.0,
      ),
      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return _darkColorScheme.surfaceVariant.withOpacity(0.5);
            }
            if (states.contains(MaterialState.selected)) {
              return _darkColorScheme.primary;
            }
            return _darkColorScheme.surfaceVariant;
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      // Divider Theme
      dividerTheme: DividerThemeData(
        color: _darkColorScheme.outline.withOpacity(0.5),
        thickness: 1,
        space: 1,
      ),
      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _darkColorScheme.inverseSurface,
        contentTextStyle: _textTheme.bodyMedium?.copyWith(
          color: _darkColorScheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 6,
      ),
    );
  }
}
