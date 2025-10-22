import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../common/styles/app_styles.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../../common/widget/gradient_background.dart';
import '../../../../data/models/login_model.dart';
import '../../../providers/auth_provider.dart';
import '../admin_dashboard/admin_dashboard_screen.dart';
import '../aluno_dashboard/aluno_dashboard_screen.dart';
import '../arena_dashboard/arena_dashboard_screen.dart';
import '../atleta_dashboard/atleta_dashboard_screen.dart';
import '../professor_dashboard/professor_dashboard_screen.dart';
import '../profissional_tecnico_dashboard/profissional_tecnico_dashboard_screen.dart';

class PerfilSelectionScreen extends StatefulWidget {
  const PerfilSelectionScreen({Key? key}) : super(key: key);

  @override
  State<PerfilSelectionScreen> createState() => _PerfilSelectionScreenState();

  static const String route = "perfil_selection";
}

class _PerfilSelectionScreenState extends State<PerfilSelectionScreen> {
  UsuarioModel? get usuario => context.read<AuthProvider>().loginData?.usuario;
  
  List<TipoUsuarioModel> get perfisAtivos => usuario?.tiposAtivos ?? [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.grey800,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppStyles.grey800,
          statusBarIconBrightness: Brightness.light,
        ),
        title: const Text(
          'SELECIONAR PERFIL',
          style: TextStyle(
            color: AppStyles.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: AppStyles.white),
            onPressed: () {
              _showHelpDialog(context);
            },
          ),
        ],
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppStyles.largeSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserHeader(),
              const SizedBox(height: AppStyles.largeSpace),
              const Text(
                'Selecione o perfil que deseja acessar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppStyles.grey900,
                ),
              ),
              const SizedBox(height: AppStyles.mediumSpace),
              _buildPerfisList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppStyles.mediumSpace),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppStyles.grey800,
              child: Text(
                usuario?.iniciais ?? 'U',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppStyles.white,
                ),
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    usuario?.nome ?? 'Usuário',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppStyles.grey900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    usuario?.email ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppStyles.grey700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppStyles.warning,
                          borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                        ),
                        child: Text(
                          '${perfisAtivos.length} PERFIS DISPONÍVEIS',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppStyles.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerfisList() {
    if (perfisAtivos.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(AppStyles.largeSpace),
          child: Text(
            'Nenhum perfil ativo encontrado.',
            style: TextStyle(
              fontSize: 16,
              color: AppStyles.grey700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: perfisAtivos.length,
      itemBuilder: (context, index) {
        final perfil = perfisAtivos[index];
        final perfilInfo = _getPerfilInfo(perfil.codigoTipo);
        
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: AppStyles.mediumSpace),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
          ),
          child: InkWell(
            onTap: () => _navigateToDashboard(perfil.codigoTipo),
            borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
            child: Padding(
              padding: const EdgeInsets.all(AppStyles.mediumSpace),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: perfilInfo['cor'],
                    child: Icon(
                      perfilInfo['icone'],
                      color: AppStyles.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: AppStyles.mediumSpace),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          perfil.nomeTipo,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppStyles.grey900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          perfilInfo['descricao'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppStyles.grey700,
                          ),
                        ),
                        if (perfil.principal)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppStyles.success,
                              borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                            ),
                            child: const Text(
                              'PRINCIPAL',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppStyles.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  CustomButton(
                    text: 'Acessar',
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    type: ButtonType.primary,
                    height: 40,
                    onPressed: () => _navigateToDashboard(perfil.codigoTipo),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Map<String, dynamic> _getPerfilInfo(String tipo) {
    switch (tipo) {
      case 'ARENA':
        return {
          'descricao': 'Administrador de Arena',
          'cor': AppStyles.primaryBlue,
          'icone': Icons.location_on,
        };
      case 'ATLETA':
        return {
          'descricao': 'Atleta de Beach Tênis',
          'cor': AppStyles.primaryGreen,
          'icone': Icons.sports_tennis,
        };
      case 'ALUNO':
        return {
          'descricao': 'Aluno de Beach Tênis',
          'cor': AppStyles.warning,
          'icone': Icons.school_outlined,
        };
      case 'PROFESSOR':
        return {
          'descricao': 'Professor de Beach Tênis',
          'cor': AppStyles.primaryBlue,
          'icone': Icons.school,
        };
      case 'PROFISSIONAL_TECNICO':
        return {
          'descricao': 'Profissional Técnico',
          'cor': AppStyles.info,
          'icone': Icons.medical_services,
        };
      case 'ADMIN':
        return {
          'descricao': 'Administrador do Sistema',
          'cor': AppStyles.error,
          'icone': Icons.admin_panel_settings,
        };
      default:
        return {
          'descricao': 'Perfil de Usuário',
          'cor': AppStyles.grey600,
          'icone': Icons.person,
        };
    }
  }

  void _navigateToDashboard(String tipo) {
    Widget dashboard;

    switch (tipo) {
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
        // Caso padrão, poderia mostrar um erro
        dashboard = const ArenaDashboardScreen();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, a1, a2) => dashboard,
        transitionsBuilder: (context, a1, a2, child) => FadeTransition(opacity: a1, child: child),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajuda - Múltiplos Perfis'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Você possui múltiplos perfis no sistema Beach Tênis.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Cada perfil dá acesso a funcionalidades diferentes:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Atleta: gerenciar jogos, torneios e estatísticas'),
                Text('• Professor: gerenciar alunos e treinos'),
                Text('• Arena: gerenciar quadras e horários'),
                Text('• Aluno: acompanhar treinos e evolução'),
                Text('• Profissional Técnico: gerenciar atendimentos'),
                Text('• Admin: gerenciar todo o sistema'),
                SizedBox(height: 16),
                Text(
                  'Você pode alternar entre perfis a qualquer momento através do menu lateral em cada dashboard.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Entendi'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
