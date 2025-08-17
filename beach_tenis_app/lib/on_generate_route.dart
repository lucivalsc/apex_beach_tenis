import 'package:beach_tenis_app/app/layers/presenter/screens/logged_in/arena_registration/arena_registration_screen.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/logged_in/athlete_registration/athlete_registration_screen.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/logged_in/payment_methods/payment_methods_screen.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/logged_in/profile_selection/profile_selection_screen.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/logged_in/subscription_selection/subscription_selection_screen.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/not_logged_in/auth/auth_screen.dart';
import "package:beach_tenis_app/app/layers/presenter/screens/not_logged_in/login/login.dart";
import 'package:beach_tenis_app/app/layers/presenter/screens/not_logged_in/splash/splash_screen.dart';
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
    case ArenaRegistrationScreen.route:
      return pageRouteBuilder(
        const ArenaRegistrationScreen(),
      );
    case AuthScreen.route:
      return pageRouteBuilder(
        const AuthScreen(),
      );
    case ProfileSelectionScreen.route:
      return pageRouteBuilder(
        const ProfileSelectionScreen(),
      );
    case SubscriptionSelectionScreen.route:
      return pageRouteBuilder(
        const SubscriptionSelectionScreen(),
      );
    case SplashScreen.route:
      return pageRouteBuilder(
        const SplashScreen(),
      );
    case PaymentMethodsScreen.route:
      return pageRouteBuilder(
        const PaymentMethodsScreen(),
      );
    case AthleteRegistrationScreen.route:
      return pageRouteBuilder(
        const AthleteRegistrationScreen(),
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
