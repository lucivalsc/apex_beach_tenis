import 'package:beach_tenis_app/app/layers/presenter/screens/not_logged_in/login/config/config_screen.dart';
import "package:beach_tenis_app/app/layers/presenter/screens/not_logged_in/login/login.dart";
import "package:beach_tenis_app/starter.dart";
import "package:flutter/material.dart";
import "package:responsive_sizer/responsive_sizer.dart";

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final args = settings.arguments != null ? settings.arguments as List<dynamic> : null;
  switch (settings.name) {
    case Starter.route:
      return MaterialPageRoute(
        builder: (context) => ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return const Starter();
          },
        ),
      );
    case Login.route:
      return pageRouteBuilder(
        const Login(),
      );
    case Config.route:
      return pageRouteBuilder(
        const Config(),
      );
  }

  return null;
}

PageRouteBuilder pageRouteBuilder(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, a1, a2) => screen,
    transitionsBuilder: (context, a1, a2, child) => FadeTransition(opacity: a1, child: child),
  );
}
