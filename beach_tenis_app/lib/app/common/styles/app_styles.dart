import 'package:flutter/material.dart';

class AppStyles {
  // Beach Tennis 40x40 Brand Colors
  static const Color primaryBlue = Color(0xFF4A90E2); // Azul primário Beach Tennis
  static const Color lightBlue = Color(0xFF87CEEB); // Azul claro Beach Tennis
  static const Color darkBlue = Color(0xFF1565C0); // Azul escuro
  static const Color primaryGreen = Color(0xFF4CAF50); // Verde sucesso
  static const Color lightGreen = Color(0xFF81C784); // Verde claro
  static const Color darkGreen = Color(0xFF388E3C); // Verde escuro

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Beach Tennis Specific Colors
  static const Color redAccent = Color(0xFFFF0000); // Vermelho para logo 40x40
  static const Color facebookBlue = Color(0xFF1877F2); // Azul Facebook
  static const Color backgroundGradientTop = lightBlue; // Topo do gradiente
  static const Color backgroundGradientBottom = primaryBlue; // Base do gradiente

  static const Color successColor = Color(0xFF4CAF50);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, lightBlue],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGreen, lightGreen],
  );

  // Legacy colors for compatibility
  final primaryColor = primaryBlue;
  final primaryColorInt = 0xFF4A90E2;
  final blackColor = black;
  final secondaryColor2 = primaryGreen;
  final secondaryColor3 = grey500;
  final colorWhite = white;
  final baseColor = primaryBlue; // Compatibilidade com código existente
  final secondaryColor = primaryGreen;
  final backgroundColor = grey50;
  final textSecondaryColor = grey600;

  Color failureScreenColor = error;
  Color successScreenColor = success;

  Map<int, Color> getSwatch() {
    return {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
  }

  // App paddings, margins and sizes:
  final screenPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20);

  // Beach Tennis specific spacing
  static const double tinySpace = 4.0;
  static const double smallSpace = 8.0;
  static const double mediumSpace = 12.0;
  static const double largeSpace = 16.0;
  static const double xLargeSpace = 20.0;
  static const double xxLargeSpace = 24.0;
  static const double hugeSpace = 32.0;

  // Border radius values
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;

  final loginPath = "lib/app/common/assets/png/logo.png";
  final logoPath = "lib/app/common/assets/png/logo.png";

  // Styles for texts:
  final boldText = const TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );
  final normalText = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
  final thinText = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w100,
    color: Colors.black,
  );
  final configSectionTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: Colors.grey.shade800,
  );
  final configSectionSubtitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade600,
  );
  final configCardTitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade800,
  );
  final configCardTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade400,
  );
  final configTagTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    color: Colors.grey.shade100,
  );
  final cardTitleTextStyle = const TextStyle(
    color: Colors.black87,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  final cardSubtitleTextStyle = const TextStyle(
    color: Colors.black38,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
  final inputTileLabel = const TextStyle(
    color: Colors.grey,
    fontSize: 14,
  );
  final inputTileValue = const TextStyle(
    color: Colors.black,
    fontSize: 14,
  );
  get appBarTitleStyle => const TextStyle(
        fontSize: 16,
        fontFamily: "RobotoSlab",
        color: Colors.white,
      );

  // Fertilink Specific Text Styles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: grey900,
  );

  // Estilos de texto utilizados nas telas principais
  final headingStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: grey800,
  );

  final bodyStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: grey700,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: grey900,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: grey900,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: grey800,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: grey700,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: grey600,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: grey800,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: grey700,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: grey600,
  );

  // Fertilink Theme Data
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: primaryBlue,
          secondary: primaryGreen,
          surface: white,
          error: error,
          onPrimary: white,
          onSecondary: white,
          onSurface: grey900,
          onError: white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryBlue,
          foregroundColor: white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryBlue,
            side: const BorderSide(color: primaryBlue),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryBlue,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: grey100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryBlue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: error, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: white,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: lightBlue,
          secondary: lightGreen,
          surface: grey800,
          error: error,
          onPrimary: black,
          onSecondary: black,
          onSurface: white,
          onError: white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: grey900,
          foregroundColor: white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightBlue,
            foregroundColor: black,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: lightBlue,
            side: const BorderSide(color: lightBlue),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: lightBlue,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: grey800,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: lightBlue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: error, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: grey800,
        ),
      );
}
