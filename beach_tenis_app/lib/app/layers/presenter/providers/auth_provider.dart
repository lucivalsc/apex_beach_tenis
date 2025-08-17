import 'package:apex_sports/app/common/models/failure_models.dart';
import 'package:apex_sports/app/layers/data/models/login_model.dart';
import 'package:apex_sports/app/layers/domain/usecases/auth/sign_in_usecase.dart';
import 'package:apex_sports/app/layers/presenter/providers/config_provider.dart';
import 'package:apex_sports/app/layers/presenter/providers/user_provider.dart';
import 'package:apex_sports/app/layers/presenter/screens/logged_in/arena_dashboard/arena_dashboard_screen.dart';
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
          // Extrair dados do usuário do mock
          final userData = responseData['usuario'] as Map<String, dynamic>;
          // Caso 2: Se precisa construir a estrutura a partir de dados separados
          final loginResponse = {
            'success': true,
            'token': userData['token'], // Token JWT do beach tênis
            'usuario': {
              'id': userData['id'] ?? 0,
              'nome': userData['nome'] ?? '',
              'telefone': userData['telefone'],
              'instagram': userData['instagram'],
              'facebook': userData['facebook'],
              'linkedin': userData['linkedin'],
              'email': userData['email'] ?? '',
              'tipo': userData['tipo'] ?? 'ALUNO', // ALUNO, PROFESSOR, ADMIN
              'ativo': userData['ativo'] ?? true,
              'ultimo_login': userData['ultimo_login'],
              'created_at': userData['created_at'],
              'updated_at': userData['updated_at'],
            }
          };

          loginData = LoginModel.fromJson(loginResponse);

          // Obter o tipo de usuário do mock para navegação condicional
          final userType = userData['tipo'] as String;

          // Salvar o tipo de usuário no storage para uso futuro
          await configProvider.saveUserType(userType);

          // Navegar para a tela específica com base no tipo de usuário

          ///'ARENA', 'ATLETA', 'ALUNO', 'PROFESSOR', 'PROFISSIONAL_TECNICO', 'ADMIN'
          if (userType == 'ALUNO') {
            // Navegar para a tela de tentante (demandante)
            Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
                pageBuilder: (context, a1, a2) => const ArenaDashboardScreen(),
                transitionsBuilder: (context, a1, a2, child) => FadeTransition(opacity: a1, child: child),
              ),
              (route) => false,
            );
          } else if (userType == 'ATLETA') {
            // Navegar para a tela de doador
            Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
                pageBuilder: (context, a1, a2) => const ArenaDashboardScreen(),
                transitionsBuilder: (context, a1, a2, child) => FadeTransition(opacity: a1, child: child),
              ),
              (route) => false,
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
}
