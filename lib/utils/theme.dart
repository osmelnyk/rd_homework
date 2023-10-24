import 'package:flutter/material.dart';
import 'package:rd_homework/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme(WidgetRef ref) {
  // Provides font family
  var selectedFont = ref.watch(fontFamilyProvider);

  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF0060A7),
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFD2E4FF),
      onPrimaryContainer: Color(0xFF001C37),
      secondary: Color(0xFF535F70),
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFD7E3F8),
      onSecondaryContainer: Color(0xFF101C2B),
      tertiary: Color(0xFF6C5677),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFF4D9FF),
      onTertiaryContainer: Color(0xFF261431),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Colors.white,
      onErrorContainer: Color(0xFF410002),
      background: Color(0xFFFDFCFF),
      onBackground: Color(0xFF1A1C1E),
      surface: Color(0xFFFDFCFF),
      onSurface: Color(0xFF1A1C1E),
      surfaceVariant: Color(0xFFDFE2EB),
      onSurfaceVariant: Color(0xFF43474E),
      outline: Color(0xFF73777F),
      onInverseSurface: Color(0xFFF1F0F4),
      inverseSurface: Color(0xFF2F3033),
      inversePrimary: Color(0xFFA1C9FF),
      shadow: Colors.black,
      surfaceTint: Color(0xFF0060A7),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
      labelMedium: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
    ).apply(
      // Get the font family from provider
      fontFamily: GoogleFonts.getFont(selectedFont.fontName).fontFamily,
    ),
  );
}

// Dark Theme
ThemeData darkTheme(WidgetRef ref) {
  var selectedFont = ref.watch(fontFamilyProvider);
  return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFA1C9FF),
        onPrimary: Color(0xFF00325A),
        primaryContainer: Color(0xFF004880),
        onPrimaryContainer: Color(0xFFD2E4FF),
        secondary: Color(0xFFBBC7DB),
        onSecondary: Color(0xFF263141),
        secondaryContainer: Color(0xFF3C4858),
        onSecondaryContainer: Color(0xFFD7E3F8),
        tertiary: Color(0xFFD8BDE4),
        onTertiary: Color(0xFF3C2947),
        tertiaryContainer: Color(0xFF533F5F),
        onTertiaryContainer: Color(0xFFF4D9FF),
        error: Color(0xFFFFB4AB),
        errorContainer: Color(0xFF93000A),
        onError: Color(0xFF690005),
        onErrorContainer: Color(0xFFFFDAD6),
        background: Color(0xFF1A1C1E),
        onBackground: Color(0xFFE3E2E6),
        surface: Color(0xFF1A1C1E),
        onSurface: Color(0xFFE3E2E6),
        surfaceVariant: Color(0xFF43474E),
        onSurfaceVariant: Color(0xFFC3C6CF),
        outline: Color(0xFF8D9199),
        onInverseSurface: Color(0xFF1A1C1E),
        inverseSurface: Color(0xFFE3E2E6),
        inversePrimary: Color(0xFF212121),
        shadow: Colors.black,
        surfaceTint: Color(0xFFA1C9FF),
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 96,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayMedium: const TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displaySmall: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineSmall: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
        titleLarge: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        titleSmall: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        labelLarge: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          color: Colors.grey[400],
        ),
        labelMedium: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Colors.grey[400],
        ),
      ).apply(
        // Get the font family from provider
        fontFamily: GoogleFonts.getFont(selectedFont.fontName).fontFamily,
      ));
}
