import 'package:beach_tenis_app/app/layers/presenter/providers/auth_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/config_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/layers/presenter/screens/not_logged_in/login/login.dart';
import 'app/layers/presenter/screens/not_logged_in/splash/splash_screen.dart';

class Starter extends StatefulWidget {
  const Starter({Key? key}) : super(key: key);

  static const route = "starter_screen";

  @override
  State<Starter> createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  late Future<void> future;
  late Widget nextScreen;
  late ConfigProvider configProvider;
  late AuthProvider authProvider;
  late DataProvider dataProvider;

  Future<void> startApp() async {
    configProvider = Provider.of<ConfigProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    dataProvider = Provider.of<DataProvider>(context, listen: false);

    // Verificar se o usuário já está logado através do email salvo
    String savedEmail = await configProvider.loadLastLoggedEmail();
    String savedPassword = await configProvider.loadLastLoggedPassword();
    String savedUserType = await configProvider.loadUserType();
    bool isLoggedIn = savedEmail.isNotEmpty && savedPassword.isNotEmpty;

    // Verificar se já passou pelo onboarding
    // Como não temos um método específico para isso, vamos usar o mesmo indicador
    // Se o usuário já fez login antes, consideramos que já viu o onboarding
    bool hasSeenOnboarding = isLoggedIn;

    if (isLoggedIn) {
      // Tentar fazer login automático com as credenciais salvas
      try {
        // Verificar o tipo de usuário para navegar para a tela correta
        if (savedUserType == 'tentante') {
          nextScreen = const Login();
        } else if (savedUserType == 'doador') {
          nextScreen = const Login();
        } else {
          // Se não conseguir identificar o tipo, vai para login
          nextScreen = const Login();
        }
      } catch (e) {
        // Em caso de erro, vai para login
        nextScreen = const Login();
      }
    } else if (hasSeenOnboarding) {
      // Usuário não logado mas já viu onboarding - vai para login
      nextScreen = const Login();
    }

    // Aguardar pelo menos 3 segundos para mostrar a splash screen
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() {
    super.initState();
    future = startApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: nextScreen,
          );
        } else {
          return const AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: SplashScreen(),
          );
        }
      },
    );
  }
}
