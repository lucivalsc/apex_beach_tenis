import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../common/styles/app_styles.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../../common/widget/gradient_background.dart';
import '../../../../data/models/login_model.dart';
import '../../../providers/auth_provider.dart';
import '../../not_logged_in/auth/auth_screen.dart';
import 'widgets/aluno_list_item.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/treino_card.dart';

class ProfessorDashboardScreen extends StatefulWidget {
  const ProfessorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ProfessorDashboardScreen> createState() => _ProfessorDashboardScreenState();

  static const String route = "professor_dashboard";
}

class _ProfessorDashboardScreenState extends State<ProfessorDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AuthProvider authProvider;
  late LoginModel? loginData;
  late UsuarioModel? usuarioData;

  // Mock data para demonstração - será substituído pelos dados do usuário logado
  final Map<String, dynamic> professorData = {
    'nome': 'Carlos Silva',
    'especialidade': 'Técnica Avançada',
    'alunos': 12,
    'arenas': ['Apex Sports', 'Beach Tennis Club'],
    'foto': null,
    'avaliacao': 4.8,
  };
  
  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    loginData = authProvider.loginData;
    usuarioData = loginData?.usuario;
    
    // Se tiver dados do usuário logado, atualiza os dados do professor
    if (usuarioData != null) {
      professorData['nome'] = usuarioData!.nome;
      professorData['email'] = usuarioData!.email;
      // Outros campos que podem ser atualizados conforme disponibilidade
    }
  }

  final List<Map<String, dynamic>> proximosTreinos = [
    {
      'data': '2023-11-15 14:00',
      'aluno': 'Maria Oliveira',
      'nivel': 'Intermediário',
      'tipo': 'Técnica',
      'arena': 'Apex Sports',
      'status': 'CONFIRMADO',
    },
    {
      'data': '2023-11-16 10:30',
      'aluno': 'João Pedro',
      'nivel': 'Iniciante',
      'tipo': 'Fundamentos',
      'arena': 'Beach Tennis Club',
      'status': 'PENDENTE',
    },
    {
      'data': '2023-11-17 16:00',
      'aluno': 'Ana Clara',
      'nivel': 'Avançado',
      'tipo': 'Tática',
      'arena': 'Apex Sports',
      'status': 'CONFIRMADO',
    },
  ];

  final List<Map<String, dynamic>> alunos = [
    {
      'nome': 'Maria Oliveira',
      'nivel': 'Intermediário',
      'foto': null,
      'progresso': 75,
      'desde': '2023-05-10',
    },
    {
      'nome': 'João Pedro',
      'nivel': 'Iniciante',
      'foto': null,
      'progresso': 40,
      'desde': '2023-08-22',
    },
    {
      'nome': 'Ana Clara',
      'nivel': 'Avançado',
      'foto': null,
      'progresso': 90,
      'desde': '2022-11-15',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppStyles.primaryBlue,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppStyles.primaryBlue,
          statusBarIconBrightness: Brightness.light,
        ),
        title: Text(
          'PROF.: ${usuarioData?.nome ?? professorData['nome']}',
          style: const TextStyle(
            color: AppStyles.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppStyles.white),
            onPressed: () {
              // Navegar para tela de notificações
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: GradientBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            // Implementar atualização dos dados
            await Future.delayed(const Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppStyles.largeSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfessorHeader(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildQuickActions(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildProximosTreinosSection(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildAlunosSection(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyles.primaryBlue,
        child: const Icon(Icons.add, color: AppStyles.white),
        onPressed: () {
          _showAddOptionsModal(context);
        },
      ),
    );
  }

  Widget _buildProfessorHeader() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppStyles.largeSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppStyles.lightBlue,
                  backgroundImage: professorData['foto'] != null ? NetworkImage(professorData['foto']) : null,
                  child: (usuarioData?.nome != null && usuarioData!.nome.isNotEmpty)
                      ? Text(
                          usuarioData!.nome.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppStyles.white,
                          ),
                        )
                      : (professorData['foto'] == null
                          ? Text(
                              professorData['nome'].substring(0, 1).toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppStyles.white,
                              ),
                            )
                          : null),
                ),
                const SizedBox(width: AppStyles.mediumSpace),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        usuarioData?.nome ?? professorData['nome'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppStyles.grey900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppStyles.primaryBlue,
                              borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                            ),
                            child: Text(
                              professorData['especialidade'],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppStyles.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: AppStyles.warning),
                              const SizedBox(width: 2),
                              Text(
                                professorData['avaliacao'].toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppStyles.grey700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppStyles.mediumSpace),
            const Divider(),
            const SizedBox(height: AppStyles.smallSpace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Alunos', professorData['alunos'].toString(), Icons.people),
                _buildStatItem('Arenas', professorData['arenas'].length.toString(), Icons.location_on),
              ],
            ),
            const SizedBox(height: AppStyles.mediumSpace),
            CustomButton(
              text: 'Editar Perfil',
              icon: const Icon(Icons.edit, size: 16),
              type: ButtonType.secondary,
              height: 40,
              onPressed: () {
                // Navegar para tela de edição de perfil
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppStyles.primaryBlue, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppStyles.grey900,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppStyles.grey600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ações Rápidas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppStyles.grey900,
          ),
        ),
        const SizedBox(height: AppStyles.mediumSpace),
        Row(
          children: [
            Expanded(
              child: DashboardCard(
                icon: Icons.fitness_center,
                title: 'Meus Treinos',
                subtitle: 'Gerenciar treinos',
                color: AppStyles.primaryBlue,
                onTap: () {
                  // Navegar para tela de treinos
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.location_on,
                title: 'Arenas',
                subtitle: 'Minhas arenas',
                color: AppStyles.grey600,
                onTap: () {
                  // Navegar para tela de arenas
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.mediumSpace),
        Row(
          children: [
            Expanded(
              child: DashboardCard(
                icon: Icons.assessment,
                title: 'Avaliações',
                subtitle: 'Avaliar alunos',
                color: AppStyles.grey600,
                onTap: () {
                  // Navegar para tela de avaliações
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.edit,
                title: 'Editar Perfil',
                subtitle: 'Atualizar dados',
                color: AppStyles.primaryBlue,
                onTap: () {
                  // Navegar para tela de edição de perfil
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProximosTreinosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Próximos Treinos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppStyles.grey900,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para tela de todos os treinos
              },
              child: const Text('Ver Todos'),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.smallSpace),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: proximosTreinos.length,
          itemBuilder: (context, index) {
            final treino = proximosTreinos[index];
            final dateTime = DateTime.parse(treino['data']);
            final dateFormatter = DateFormat('dd/MM/yyyy');
            final timeFormatter = DateFormat('HH:mm');

            return TreinoCard(
              date: dateTime,
              formattedDate: dateFormatter.format(dateTime),
              formattedTime: timeFormatter.format(dateTime),
              alunoNome: treino['aluno'],
              alunoNivel: treino['nivel'],
              tipo: treino['tipo'],
              arena: treino['arena'],
              status: treino['status'],
              onTap: () {
                // Navegar para detalhes do treino
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildAlunosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Meus Alunos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppStyles.grey900,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para tela de todos os alunos
              },
              child: const Text('Ver Todos'),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.smallSpace),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: alunos.length,
          itemBuilder: (context, index) {
            final aluno = alunos[index];
            final desde = DateTime.parse(aluno['desde']);
            final desdeFormatter = DateFormat('MM/yyyy');

            return AlunoListItem(
              name: aluno['nome'],
              photoUrl: aluno['foto'],
              level: aluno['nivel'],
              progress: aluno['progresso'],
              since: 'Desde: ${desdeFormatter.format(desde)}',
              onTap: () {
                // Navegar para detalhes do aluno
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppStyles.primaryBlue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppStyles.white,
                  backgroundImage: professorData['foto'] != null ? NetworkImage(professorData['foto']) : null,
                  child: (usuarioData?.nome != null && usuarioData!.nome.isNotEmpty)
                      ? Text(
                          usuarioData!.nome.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppStyles.primaryBlue,
                          ),
                        )
                      : (professorData['foto'] == null
                          ? Text(
                              professorData['nome'].substring(0, 1).toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppStyles.primaryBlue,
                              ),
                            )
                          : null),
                ),
                const SizedBox(height: AppStyles.smallSpace),
                Text(
                  'Prof. ${usuarioData?.nome ?? professorData['nome']}',
                  style: const TextStyle(
                    color: AppStyles.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  professorData['especialidade'],
                  style: const TextStyle(
                    color: AppStyles.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            selected: true,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Meus Treinos'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de treinos
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Meus Alunos'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de alunos
            },
          ),
          ListTile(
            leading: const Icon(Icons.assessment),
            title: const Text('Avaliações'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de avaliações
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Arenas'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de arenas
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de configurações
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Ajuda'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de ajuda
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              Navigator.pop(context);
              // Redirecionar para a tela de login
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(AppStyles.largeSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Adicionar Novo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppStyles.grey900,
                ),
              ),
              const SizedBox(height: AppStyles.largeSpace),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.primaryBlue,
                  child: Icon(Icons.fitness_center, color: AppStyles.white),
                ),
                title: const Text('Novo Treino'),
                subtitle: const Text('Agendar um treino'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de agendamento de treino
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.primaryGreen,
                  child: Icon(Icons.assessment, color: AppStyles.white),
                ),
                title: const Text('Nova Avaliação'),
                subtitle: const Text('Criar avaliação para aluno'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de criação de avaliação
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.warning,
                  child: Icon(Icons.people, color: AppStyles.white),
                ),
                title: const Text('Novo Aluno'),
                subtitle: const Text('Adicionar aluno à lista'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de adição de aluno
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
