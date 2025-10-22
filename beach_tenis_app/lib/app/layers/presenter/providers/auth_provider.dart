import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/layers/data/models/login_model.dart';
import 'package:apex_sports/app/layers/domain/usecases/auth/sign_in_usecase.dart';
import 'package:apex_sports/app/layers/presenter/providers/config_provider.dart';
import 'package:apex_sports/app/layers/presenter/providers/user_provider.dart';
import 'package:apex_sports/app/layers/presenter/screens/logged_in/admin_dashboard/admin_dashboard_screen.dart';
import 'package:apex_sports/app/layers/presenter/screens/logged_in/aluno_dashboard/aluno_dashboard_screen.dart';
import 'package:apex_sports/app/layers/presenter/screens/logged_in/arena_dashboard/arena_dashboard_screen.dart';
import 'package:apex_sports/app/layers/presenter/screens/logged_in/atleta_dashboard/atleta_dashboard_screen.dart';
import 'package:apex_sports/app/layers/presenter/screens/logged_in/perfil_selection/perfil_selection_screen.dart';
import 'package:apex_sports/app/layers/presenter/screens/logged_in/professor_dashboard/professor_dashboard_screen.dart';
import 'package:apex_sports/app/layers/presenter/screens/logged_in/profissional_tecnico_dashboard/profissional_tecnico_dashboard_screen.dart';
import 'package:apex_sports/functions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final SignInUsecase signInUsecase;

  late UserProvider userProvider;
  late ConfigProvider configProvider;

  AuthProvider(
    this.signInUsecase,
  );

  void setUserProvider(UserProvider provider) => userProvider = provider;
  void setConfigProvider(ConfigProvider provider) => configProvider = provider;

  Future<void> signIn(BuildContext context, bool mounted, email, password) async {
    final result = await signInUsecase([email, password]);
    await configProvider.saveLastLoggedEmail(email);
    await configProvider.saveLastLoggedPassword(password);

    if (mounted) {
      await fold(context, result);
    }
  }

  late LoginModel? loginData;

  Future<void> fold(
    BuildContext context,
    Either<Failure, List<Object>> result,
  ) async {
    result.fold(
      (l) async {
        showFlushbar(
          context,
          l.title!,
          l.message!,
          3,
        );
      },
      (r) async {
        // Processar dados do mock do Fertilink
        final responseData = r[0] as Map<String, dynamic>;

        if (responseData['success'] == true && responseData['usuario'] != null) {
          // Usar a estrutura direta da nova API
          loginData = LoginModel.fromJson(responseData);

          if (loginData?.isValid == true) {
            // Salvar o token no storage
            // await configProvider.saveUserToken(loginData!.token!);

            // Verificar se o usuário tem múltiplos perfis ativos
            if (loginData!.hasMultipleProfiles) {
              // Se o usuário tem múltiplos perfis, navegar para a tela de seleção de perfil
              Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  pageBuilder: (context, a1, a2) => const PerfilSelectionScreen(),
                  transitionsBuilder: (context, a1, a2, child) => FadeTransition(opacity: a1, child: child),
                ),
                (route) => false,
              );
            } else {
              // Obter o tipo principal do usuário
              final userType = loginData!.tipoUsuario;

              // Salvar o tipo de usuário no storage para uso futuro
              await configProvider.saveUserType(userType);

              // Navegar para a tela específica com base no tipo de usuário
              _navigateToUserDashboard(context, userType);
            }
          } else {
            showFlushbar(
              context,
              'Erro de Login',
              'Dados de login inválidos. Tente novamente.',
              3,
            );
          }
        } else {
          // Caso de erro inesperado na resposta
          showFlushbar(
            context,
            'Erro de Login',
            'Resposta inválida do servidor. Tente novamente.',
            3,
          );
        }
      },
    );
  }

  /// Navega para o dashboard específico baseado no tipo de usuário
  void _navigateToUserDashboard(BuildContext context, String userType) {
    Widget dashboard;

    switch (userType) {
      case 'ARENA':
        dashboard = const ArenaDashboardScreen();
        break;
      case 'ATLETA':
        dashboard = const AtletaDashboardScreen();
        break;
      case 'ALUNO':
        dashboard = const AlunoDashboardScreen();
        break;
      case 'PROFESSOR':
        dashboard = const ProfessorDashboardScreen();
        break;
      case 'PROFISSIONAL_TECNICO':
        dashboard = const ProfissionalTecnicoDashboardScreen();
        break;
      case 'ADMIN':
        dashboard = const AdminDashboardScreen();
        break;
      default:
        // Caso o tipo não seja reconhecido, mostrar mensagem de erro
        showFlushbar(
          context,
          'Erro de Acesso',
          'Tipo de usuário não reconhecido: $userType',
          3,
        );
        return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, a1, a2) => dashboard,
        transitionsBuilder: (context, a1, a2, child) => FadeTransition(opacity: a1, child: child),
      ),
      (route) => false,
    );
  }
}
