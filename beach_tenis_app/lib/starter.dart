import 'package:beach_tenis_app/app/layers/presenter/providers/auth_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/config_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/data_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/not_logged_in/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/layers/presenter/screens/not_logged_in/splash/splash_screen.dart';

class Starter extends StatefulWidget {
  const Starter({Key? key}) : super(key: key);

  static const route = "starter_screen";

  @override
  State<Starter> createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  late Future<void> future;
  Widget nextScreen = const SplashScreen(); // Inicialização com valor padrão
  late ConfigProvider configProvider;
  late AuthProvider authProvider;
  late DataProvider dataProvider;

  Future<void> startApp() async {
    try {
      configProvider = Provider.of<ConfigProvider>(context, listen: false);
      authProvider = Provider.of<AuthProvider>(context, listen: false);
      dataProvider = Provider.of<DataProvider>(context, listen: false);

      // Verificar se o usuário já está logado através do email salvo
      String lastEmail = await configProvider.loadLastLoggedEmail();
      bool isLoggedIn = lastEmail.isNotEmpty;
      String savedUserType = await configProvider.loadUserType();

      // Verificar se já passou pelo onboarding
      // Como não temos um método específico para isso, vamos usar o mesmo indicador
      // Se o usuário já fez AuthScreen antes, consideramos que já viu o onboarding
      bool hasSeenOnboarding = isLoggedIn;

      // Definir a próxima tela com base no estado de autenticação
      setState(() {
        if (isLoggedIn) {
          // Usuário já está logado
          if (savedUserType == 'arena') {
            // Navegar para a tela principal da arena
            nextScreen = const AuthScreen(); // Substitua pela tela principal da arena
          } else if (savedUserType == 'atleta') {
            // Navegar para a tela principal do atleta
            nextScreen = const AuthScreen(); // Substitua pela tela principal do atleta
          } else {
            // Tipo de usuário não reconhecido ou não definido
            nextScreen = const AuthScreen();
          }
        } else if (hasSeenOnboarding) {
          // Usuário não logado mas já viu onboarding
          nextScreen = const AuthScreen();
        } else {
          // Usuário novo - mantém na SplashScreen e depois vai para onboarding
          nextScreen = const AuthScreen(); // Substitua pela tela de onboarding quando existir
        }
      });
    } catch (e) {
      // Em caso de erro, garantir que nextScreen tenha um valor válido
      setState(() {
        nextScreen = const AuthScreen();
      });
      print('Erro ao inicializar o aplicativo: $e');
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
