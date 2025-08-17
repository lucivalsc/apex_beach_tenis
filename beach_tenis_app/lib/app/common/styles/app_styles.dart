import 'package:flutter/material.dart';

class AppStyles {
  // Beach Tennis 40x40 Brand Colors
  static const Color primaryBlue = Color(0xFF4A90E2); // Azul primário Beach Tennis
  static const Color lightBlue = Color(0xFF87CEEB); // Azul claro Beach Tennis
  static const Color darkBlue = Color(0xFF1565C0); // Azul escuro
  static const Color primaryGreen = Color(0xFF4CAF50); // Verde sucesso
  static const Color lightGreen = Color(0xFF81C784); // Verde claro
  static const Color darkGreen = Color(0xFF388E3C); // Verde escuro

  // Neutral Colors - Melhorado para melhor contraste
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
  static const Color grey850 = Color(0xFF303030); // Adicionado para modo escuro
  static const Color grey900 = Color(0xFF212121);
  static const Color grey950 = Color(0xFF0D1117); // Adicionado para fundos muito escuros

  // Status Colors - Ajustado para melhor visibilidade
  static const Color success = Color(0xFF2E7D32); // Mais escuro para melhor contraste
  static const Color successLight = Color(0xFF4CAF50); // Para modo escuro
  static const Color error = Color(0xFFD32F2F); // Mais legível
  static const Color errorLight = Color(0xFFEF5350); // Para modo escuro
  static const Color warning = Color(0xFFE65100); // Mais contrastante
  static const Color warningLight = Color(0xFFFF9800); // Para modo escuro
  static const Color info = Color(0xFF1976D2); // Mais escuro
  static const Color infoLight = Color(0xFF42A5F5); // Para modo escuro

  // Beach Tennis Specific Colors
  static const Color redAccent = Color(0xFFE53935); // Melhor contraste que o vermelho puro
  static const Color redAccentDark = Color(0xFFEF5350); // Para modo escuro
  static const Color facebookBlue = Color(0xFF1877F2);
  static const Color backgroundGradientTop = lightBlue;
  static const Color backgroundGradientBottom = primaryBlue;

  // Cores otimizadas para modo escuro
  static const Color primaryBlueDark = Color(0xFF64B5F6); // Mais claro para modo escuro
  static const Color primaryGreenDark = Color(0xFF66BB6A); // Mais claro para modo escuro

  static const Color successColor = Color(0xFF4CAF50);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, lightBlue],
  );

  static const LinearGradient primaryGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlueDark, lightBlue],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGreen, lightGreen],
  );

  static const LinearGradient secondaryGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGreenDark, lightGreen],
  );

  // Legacy colors for compatibility
  final primaryColor = primaryBlue;
  final primaryColorInt = 0xFF4A90E2;
  final blackColor = black;
  final secondaryColor2 = primaryGreen;
  final secondaryColor3 = grey500;
  final colorWhite = white;
  final baseColor = primaryBlue;
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

  // Styles for texts - Melhorado para melhor contraste:
  final boldText = const TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    color: grey900,
  );
  final normalText = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w300,
    color: grey800,
  );
  final thinText = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w100,
    color: grey700,
  );
  final configSectionTitleStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: grey900,
  );
  final configSectionSubtitleStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: grey600,
  );
  final configCardTitleStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: grey800,
  );
  final configCardTextStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: grey600,
  );
  final configTagTextStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    color: white,
  );
  final cardTitleTextStyle = const TextStyle(
    color: grey900,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  final cardSubtitleTextStyle = const TextStyle(
    color: grey600,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
  final inputTileLabel = const TextStyle(
    color: grey600,
    fontSize: 14,
  );
  final inputTileValue = const TextStyle(
    color: grey900,
    fontSize: 14,
  );
  get appBarTitleStyle => const TextStyle(
        fontSize: 16,
        fontFamily: "RobotoSlab",
        color: white,
      );

  // Text Styles com melhor contraste
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: grey900,
  );

  final headingStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: grey900,
  );

  final bodyStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: grey800,
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

  // MODO CLARO - Otimizado para melhor contraste
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: primaryBlue,
          onPrimary: white,
          primaryContainer: Color(0xFFE3F2FD),
          onPrimaryContainer: Color(0xFF0D47A1),
          secondary: primaryGreen,
          onSecondary: white,
          secondaryContainer: Color(0xFFE8F5E8),
          onSecondaryContainer: Color(0xFF1B5E20),
          tertiary: redAccent,
          onTertiary: white,
          error: error,
          onError: white,
          errorContainer: Color(0xFFFFEBEE),
          onErrorContainer: Color(0xFFB71C1C),
          surface: white,
          onSurface: grey900,
          onSurfaceVariant: grey700,
          outline: grey400,
          outlineVariant: grey200,
          shadow: Color(0x1F000000),
          scrim: Color(0x80000000),
          inverseSurface: grey850,
          onInverseSurface: grey100,
          inversePrimary: primaryBlueDark,
          surfaceTint: primaryBlue,
        ),
        scaffoldBackgroundColor: grey50,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryBlue,
          foregroundColor: white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: white),
          actionsIconTheme: IconThemeData(color: white),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: white,
            letterSpacing: 0.15,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: white,
            disabledBackgroundColor: grey300,
            disabledForegroundColor: grey600,
            elevation: 2,
            shadowColor: const Color(0x3F000000),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            minimumSize: const Size(88, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryBlue,
            disabledForegroundColor: grey400,
            side: const BorderSide(color: primaryBlue, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            minimumSize: const Size(88, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryBlue,
            disabledForegroundColor: grey400,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            minimumSize: const Size(64, 40),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: grey100,
          hoverColor: grey200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: grey300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: grey300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryBlue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: error, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: error, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: grey200),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: const TextStyle(color: grey600, fontSize: 16),
          hintStyle: const TextStyle(color: grey500, fontSize: 16),
          helperStyle: const TextStyle(color: grey600, fontSize: 12),
          errorStyle: const TextStyle(color: error, fontSize: 12),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shadowColor: const Color(0x1A000000),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: white,
          margin: const EdgeInsets.all(4),
        ),
        dividerTheme: const DividerThemeData(
          color: grey200,
          thickness: 1,
          space: 16,
        ),
        iconTheme: const IconThemeData(
          color: grey700,
          size: 24,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: grey900, fontSize: 57, fontWeight: FontWeight.w400),
          displayMedium: TextStyle(color: grey900, fontSize: 45, fontWeight: FontWeight.w400),
          displaySmall: TextStyle(color: grey900, fontSize: 36, fontWeight: FontWeight.w400),
          headlineLarge: TextStyle(color: grey900, fontSize: 32, fontWeight: FontWeight.w400),
          headlineMedium: TextStyle(color: grey900, fontSize: 28, fontWeight: FontWeight.w400),
          headlineSmall: TextStyle(color: grey900, fontSize: 24, fontWeight: FontWeight.w400),
          titleLarge: TextStyle(color: grey900, fontSize: 22, fontWeight: FontWeight.w400),
          titleMedium: TextStyle(color: grey900, fontSize: 16, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: grey800, fontSize: 14, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(color: grey700, fontSize: 14, fontWeight: FontWeight.w400),
          bodySmall: TextStyle(color: grey600, fontSize: 12, fontWeight: FontWeight.w400),
          labelLarge: TextStyle(color: grey800, fontSize: 14, fontWeight: FontWeight.w500),
          labelMedium: TextStyle(color: grey700, fontSize: 12, fontWeight: FontWeight.w500),
          labelSmall: TextStyle(color: grey600, fontSize: 11, fontWeight: FontWeight.w500),
        ),
      );

  // MODO ESCURO - Otimizado para melhor contraste e conforto visual
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: primaryBlueDark,
          onPrimary: grey900,
          primaryContainer: Color(0xFF004881),
          onPrimaryContainer: Color(0xFFB3E5FC),
          secondary: primaryGreenDark,
          onSecondary: grey900,
          secondaryContainer: Color(0xFF2E7D32),
          onSecondaryContainer: Color(0xFFC8E6C9),
          tertiary: redAccentDark,
          onTertiary: grey900,
          error: errorLight,
          onError: grey900,
          errorContainer: Color(0xFFB71C1C),
          onErrorContainer: Color(0xFFFFCDD2),
          surface: grey850,
          onSurface: grey100,
          onSurfaceVariant: grey300,
          outline: grey600,
          outlineVariant: grey700,
          shadow: Color(0x3F000000),
          scrim: Color(0xB3000000),
          inverseSurface: grey100,
          onInverseSurface: grey850,
          inversePrimary: primaryBlue,
          surfaceTint: primaryBlueDark,
        ),
        scaffoldBackgroundColor: grey950,
        appBarTheme: const AppBarTheme(
          backgroundColor: grey900,
          foregroundColor: grey100,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: grey100),
          actionsIconTheme: IconThemeData(color: grey100),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: grey100,
            letterSpacing: 0.15,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlueDark,
            foregroundColor: grey900,
            disabledBackgroundColor: grey700,
            disabledForegroundColor: grey500,
            elevation: 2,
            shadowColor: const Color(0x4F000000),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            minimumSize: const Size(88, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryBlueDark,
            disabledForegroundColor: grey600,
            side: const BorderSide(color: primaryBlueDark, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            minimumSize: const Size(88, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryBlueDark,
            disabledForegroundColor: grey600,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            minimumSize: const Size(64, 40),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: grey800,
          hoverColor: grey700,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: grey600),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: grey600),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryBlueDark, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: errorLight, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: errorLight, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: grey700),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: const TextStyle(color: grey300, fontSize: 16),
          hintStyle: const TextStyle(color: grey500, fontSize: 16),
          helperStyle: const TextStyle(color: grey400, fontSize: 12),
          errorStyle: const TextStyle(color: errorLight, fontSize: 12),
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shadowColor: const Color(0x2F000000),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: grey800,
          margin: const EdgeInsets.all(4),
        ),
        dividerTheme: const DividerThemeData(
          color: grey600,
          thickness: 1,
          space: 16,
        ),
        iconTheme: const IconThemeData(
          color: grey300,
          size: 24,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: grey100, fontSize: 57, fontWeight: FontWeight.w400),
          displayMedium: TextStyle(color: grey100, fontSize: 45, fontWeight: FontWeight.w400),
          displaySmall: TextStyle(color: grey100, fontSize: 36, fontWeight: FontWeight.w400),
          headlineLarge: TextStyle(color: grey100, fontSize: 32, fontWeight: FontWeight.w400),
          headlineMedium: TextStyle(color: grey100, fontSize: 28, fontWeight: FontWeight.w400),
          headlineSmall: TextStyle(color: grey100, fontSize: 24, fontWeight: FontWeight.w400),
          titleLarge: TextStyle(color: grey100, fontSize: 22, fontWeight: FontWeight.w400),
          titleMedium: TextStyle(color: grey200, fontSize: 16, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: grey200, fontSize: 14, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: grey200, fontSize: 16, fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(color: grey300, fontSize: 14, fontWeight: FontWeight.w400),
          bodySmall: TextStyle(color: grey400, fontSize: 12, fontWeight: FontWeight.w400),
          labelLarge: TextStyle(color: grey200, fontSize: 14, fontWeight: FontWeight.w500),
          labelMedium: TextStyle(color: grey300, fontSize: 12, fontWeight: FontWeight.w500),
          labelSmall: TextStyle(color: grey400, fontSize: 11, fontWeight: FontWeight.w500),
        ),
      );
}
