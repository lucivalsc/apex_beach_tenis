import 'package:beach_tenis_app/app/common/providers/theme_provider.dart';
import 'package:beach_tenis_app/app/common/styles/app_styles.dart';
import 'package:beach_tenis_app/app/common/utils/functions.dart';
import 'package:beach_tenis_app/app/common/widget/safe_bottom_padding.dart';
import 'package:beach_tenis_app/on_generate_route.dart';
import 'package:beach_tenis_app/provider_injections.dart';
import 'package:beach_tenis_app/starter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_localizations/flutter_localizations.dart";
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromRGBO(242, 242, 242, 1),
      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );
  await startHiveStuff();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Builder(
        builder: (context) {
          // Acessa o ThemeProvider para obter o tema atual
          final themeProvider = Provider.of<ThemeProvider>(context);
          
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale("pt", "BR")],
            // Usa o tema do ThemeProvider
            theme: AppStyles.lightTheme,
            darkTheme: AppStyles.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: Starter.route,
            onGenerateRoute: onGenerateRoute,
            // Builder personalizado para aplicar SafeBottomPadding em todas as telas
            builder: (context, child) {
              // Aplica o SafeBottomPadding em todas as telas
              return SafeBottomPadding(child: child ?? Container());
            },
          );
        },
      ),
    );
  }
}
