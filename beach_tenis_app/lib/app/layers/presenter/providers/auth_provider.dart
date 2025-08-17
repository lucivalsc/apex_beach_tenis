import 'package:beach_tenis_app/app/common/models/failure_models.dart';
import 'package:beach_tenis_app/app/layers/data/models/login_model.dart';
import 'package:beach_tenis_app/app/layers/data/models/usuario_model.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/auth/sign_in_usecase.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/config_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/user_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/not_logged_in/auth/auth_screen.dart';
import 'package:beach_tenis_app/functions.dart';
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
    usuario = UsuarioModel();
    empresa = LoginModelEmpresas();
    usuario.user = email;
    usuario.password = password;
    if (mounted) {
      await fold(context, result);
    }
  }

  late LoginModel? loginData;
  late UsuarioModel usuario;
  late LoginModelEmpresas empresa;

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

        if (responseData['success'] == true && responseData['user'] != null) {
          // Extrair dados do usuário do mock
          final userData = responseData['user'] as Map<String, dynamic>;

          // Criar estrutura compatível com LoginModel (sem empresas para Fertilink)
          final loginResponse = {
            'success': true,
            'ucusername': userData['nome'],
            'uclogin': userData['email'],
            'ucemail': userData['email'],
            // Para o Fertilink, não usamos empresas, então criamos uma estrutura vazia ou omitimos
          };

          loginData = LoginModel.fromJson(loginResponse);

          // Salvar dados básicos usando métodos disponíveis
          // Nota: UserProvider e ConfigProvider não têm métodos específicos para dados do usuário
          // Os dados do usuário estão disponíveis em loginData para uso posterior

          // Obter o tipo de usuário do mock para navegação condicional
          final userType = userData['tipo_usuario'] as String;

          // Salvar o tipo de usuário no storage para uso futuro
          await configProvider.saveUserType(userType);

          // Navegar para a tela específica com base no tipo de usuário
          if (userType == 'tentante') {
            // Navegar para a tela de tentante (demandante)
            Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
                pageBuilder: (context, a1, a2) => const AuthScreen(),
                transitionsBuilder: (context, a1, a2, child) => FadeTransition(opacity: a1, child: child),
              ),
              (route) => false,
            );
          } else if (userType == 'doador') {
            // Navegar para a tela de doador
            Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
                pageBuilder: (context, a1, a2) => const AuthScreen(),
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
