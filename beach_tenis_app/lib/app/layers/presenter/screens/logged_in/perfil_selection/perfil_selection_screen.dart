import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../common/styles/app_styles.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../../common/widget/gradient_background.dart';
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
  // Mock data para demonstração
  final Map<String, dynamic> userData = {
    'nome': 'João Silva',
    'email': 'joao.silva@email.com',
    'foto': null,
  };

  final List<Map<String, dynamic>> perfis = [
    {
      'tipo': 'ATLETA',
      'descricao': 'Atleta de Beach Tênis',
      'cor': AppStyles.primaryGreen,
      'icone': Icons.sports_tennis,
    },
    {
      'tipo': 'PROFESSOR',
      'descricao': 'Professor de Beach Tênis',
      'cor': AppStyles.primaryBlue,
      'icone': Icons.school,
    },
    {
      'tipo': 'ARENA',
      'descricao': 'Administrador de Arena',
      'cor': AppStyles.primaryBlue,
      'icone': Icons.location_on,
    },
  ];

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
              backgroundImage: userData['foto'] != null
                  ? NetworkImage(userData['foto'])
                  : null,
              child: userData['foto'] == null
                  ? Text(
                      userData['nome'].substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppStyles.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData['nome'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppStyles.grey900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userData['email'],
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
                          '${perfis.length} PERFIS DISPONÍVEIS',
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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: perfis.length,
      itemBuilder: (context, index) {
        final perfil = perfis[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: AppStyles.mediumSpace),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
          ),
          child: InkWell(
            onTap: () => _navigateToDashboard(perfil['tipo']),
            borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
            child: Padding(
              padding: const EdgeInsets.all(AppStyles.mediumSpace),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: perfil['cor'],
                    child: Icon(
                      perfil['icone'],
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
                          _getTipoFormatado(perfil['tipo']),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppStyles.grey900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          perfil['descricao'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppStyles.grey700,
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
                    onPressed: () => _navigateToDashboard(perfil['tipo']),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getTipoFormatado(String tipo) {
    switch (tipo) {
      case 'ARENA':
        return 'Arena';
      case 'ATLETA':
        return 'Atleta';
      case 'ALUNO':
        return 'Aluno';
      case 'PROFESSOR':
        return 'Professor';
      case 'PROFISSIONAL_TECNICO':
        return 'Profissional Técnico';
      case 'ADMIN':
        return 'Administrador';
      default:
        return tipo;
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
