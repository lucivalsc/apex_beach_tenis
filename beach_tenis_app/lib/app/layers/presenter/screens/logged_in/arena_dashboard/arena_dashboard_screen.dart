import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../../common/styles/app_styles.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../../common/widget/gradient_background.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/dashboard_stats_card.dart';
import 'widgets/professor_list_item.dart';
import 'widgets/upcoming_event_card.dart';

class ArenaDashboardScreen extends StatefulWidget {
  const ArenaDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ArenaDashboardScreen> createState() => _ArenaDashboardScreenState();

  static const String route = "arena_dashboard";
}

class _ArenaDashboardScreenState extends State<ArenaDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Mock data para demonstração
  final Map<String, dynamic> arenaData = {
    'nome': 'Arena Beach Tennis 40x40',
    'status_assinatura': 'ATIVO',
    'data_vencimento': '2023-12-31',
    'endereco': 'Av. Beira Mar, 1000, Praia Grande',
    'telefone': '(11) 99999-9999',
    'whatsapp': true,
    'instagram': '@arena40x40',
    'facebook': 'arena40x40',
  };

  final List<Map<String, dynamic>> upcomingEvents = [
    {
      'tipo': 'TREINO',
      'data': '2023-11-15 14:00',
      'professor': 'Carlos Silva',
      'aluno': 'Maria Oliveira',
      'status': 'AGENDADO',
    },
    {
      'tipo': 'JOGO',
      'data': '2023-11-16 16:30',
      'participantes': ['João Pedro', 'Ana Clara', 'Roberto Mendes', 'Carla Santos'],
      'status': 'AGENDADO',
    },
    {
      'tipo': 'AVALIAÇÃO',
      'data': '2023-11-17 10:00',
      'professor': 'Carlos Silva',
      'aluno': 'Pedro Almeida',
      'status': 'AGENDADO',
    },
  ];

  final List<Map<String, dynamic>> professores = [
    {
      'nome': 'Carlos Silva',
      'foto': null,
      'especialidade': 'Técnica Avançada',
      'alunos': 12,
    },
    {
      'nome': 'Ana Beatriz',
      'foto': null,
      'especialidade': 'Iniciantes',
      'alunos': 8,
    },
    {
      'nome': 'Roberto Mendes',
      'foto': null,
      'especialidade': 'Competição',
      'alunos': 6,
    },
  ];

  final Map<String, int> estatisticas = {
    'alunos_ativos': 26,
    'professores': 3,
    'treinos_semana': 18,
    'jogos_semana': 7,
  };

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
        title: const Text(
          'Dashboard Arena',
          style: TextStyle(
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
          IconButton(
            icon: const Icon(Icons.menu, color: AppStyles.white),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: _buildDrawer(),
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
                _buildArenaHeader(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildQuickActions(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildStatisticsSection(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildUpcomingEventsSection(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildProfessoresSection(),
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

  Widget _buildArenaHeader() {
    final formatter = DateFormat('dd/MM/yyyy');
    final dataVencimento = DateTime.parse(arenaData['data_vencimento']);

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
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppStyles.lightBlue,
                  child: Icon(
                    Icons.sports_tennis,
                    size: 30,
                    color: AppStyles.white,
                  ),
                ),
                const SizedBox(width: AppStyles.mediumSpace),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        arenaData['nome'],
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
                              color: arenaData['status_assinatura'] == 'ATIVO' ? AppStyles.success : AppStyles.warning,
                              borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                            ),
                            child: Text(
                              arenaData['status_assinatura'],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppStyles.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Venc: ${formatter.format(dataVencimento)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppStyles.grey700,
                            ),
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
              children: [
                const Icon(Icons.location_on, size: 16, color: AppStyles.grey600),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    arenaData['endereco'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppStyles.grey700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppStyles.smallSpace),
            Row(
              children: [
                const Icon(Icons.phone, size: 16, color: AppStyles.grey600),
                const SizedBox(width: 4),
                Text(
                  arenaData['telefone'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppStyles.grey700,
                  ),
                ),
                if (arenaData['whatsapp']) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppStyles.success,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'WhatsApp',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppStyles.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppStyles.smallSpace),
            Row(
              children: [
                const Icon(Icons.public, size: 16, color: AppStyles.grey600),
                const SizedBox(width: 4),
                Text(
                  arenaData['instagram'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppStyles.grey700,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  arenaData['facebook'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppStyles.grey700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppStyles.mediumSpace),
            CustomButton(
              text: 'Editar Informações',
              icon: const Icon(Icons.edit, size: 16),
              type: ButtonType.secondary,
              height: 40,
              onPressed: () {
                // Navegar para tela de edição
              },
            ),
          ],
        ),
      ),
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
                icon: Icons.people,
                title: 'Alunos',
                subtitle: 'Gerenciar alunos',
                color: AppStyles.primaryBlue,
                onTap: () {
                  // Navegar para tela de alunos
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.sports_tennis,
                title: 'Treinos',
                subtitle: 'Agendar treinos',
                color: AppStyles.primaryGreen,
                onTap: () {
                  // Navegar para tela de treinos
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
                icon: Icons.event,
                title: 'Jogos',
                subtitle: 'Organizar partidas',
                color: AppStyles.warning,
                onTap: () {
                  // Navegar para tela de jogos
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.assessment,
                title: 'Relatórios',
                subtitle: 'Ver estatísticas',
                color: AppStyles.info,
                onTap: () {
                  // Navegar para tela de relatórios
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatisticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Estatísticas',
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
              child: DashboardStatsCard(
                title: 'Alunos Ativos',
                value: estatisticas['alunos_ativos'].toString(),
                icon: Icons.people,
                color: AppStyles.primaryBlue,
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardStatsCard(
                title: 'Professores',
                value: estatisticas['professores'].toString(),
                icon: Icons.school,
                color: AppStyles.primaryGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.mediumSpace),
        Row(
          children: [
            Expanded(
              child: DashboardStatsCard(
                title: 'Treinos/Semana',
                value: estatisticas['treinos_semana'].toString(),
                icon: Icons.fitness_center,
                color: AppStyles.warning,
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardStatsCard(
                title: 'Jogos/Semana',
                value: estatisticas['jogos_semana'].toString(),
                icon: Icons.sports_tennis,
                color: AppStyles.info,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUpcomingEventsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Próximos Eventos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppStyles.grey900,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para tela de todos os eventos
              },
              child: const Text('Ver Todos'),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.smallSpace),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: upcomingEvents.length,
          itemBuilder: (context, index) {
            final event = upcomingEvents[index];
            return UpcomingEventCard(
              type: event['tipo'],
              date: DateTime.parse(event['data']),
              title: event['tipo'] == 'JOGO'
                  ? 'Jogo de Duplas'
                  : event['tipo'] == 'TREINO'
                      ? 'Treino com ${event['professor']}'
                      : 'Avaliação de ${event['aluno']}',
              subtitle: event['tipo'] == 'JOGO'
                  ? '${event['participantes'][0]} e ${event['participantes'][1]} vs ${event['participantes'][2]} e ${event['participantes'][3]}'
                  : event['tipo'] == 'TREINO'
                      ? 'Aluno: ${event['aluno']}'
                      : 'Professor: ${event['professor']}',
              status: event['status'],
              onTap: () {
                // Navegar para detalhes do evento
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildProfessoresSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Professores',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppStyles.grey900,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para tela de todos os professores
              },
              child: const Text('Ver Todos'),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.smallSpace),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: professores.length,
          itemBuilder: (context, index) {
            final professor = professores[index];
            return ProfessorListItem(
              name: professor['nome'],
              photoUrl: professor['foto'],
              specialty: professor['especialidade'],
              studentCount: professor['alunos'],
              onTap: () {
                // Navegar para detalhes do professor
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
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppStyles.white,
                  child: Icon(
                    Icons.sports_tennis,
                    size: 30,
                    color: AppStyles.primaryBlue,
                  ),
                ),
                const SizedBox(height: AppStyles.smallSpace),
                Text(
                  arenaData['nome'],
                  style: const TextStyle(
                    color: AppStyles.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Assinatura: ${arenaData['status_assinatura']}',
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
            leading: const Icon(Icons.people),
            title: const Text('Alunos'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de alunos
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Professores'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de professores
            },
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Treinos'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de treinos
            },
          ),
          ListTile(
            leading: const Icon(Icons.sports_tennis),
            title: const Text('Jogos'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de jogos
            },
          ),
          ListTile(
            leading: const Icon(Icons.assessment),
            title: const Text('Relatórios'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de relatórios
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
              // Implementar logout
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
                  child: Icon(Icons.person_add, color: AppStyles.white),
                ),
                title: const Text('Novo Aluno'),
                subtitle: const Text('Cadastrar um novo aluno na arena'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de cadastro de aluno
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.primaryGreen,
                  child: Icon(Icons.school, color: AppStyles.white),
                ),
                title: const Text('Novo Professor'),
                subtitle: const Text('Adicionar um professor à equipe'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de cadastro de professor
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.warning,
                  child: Icon(Icons.event, color: AppStyles.white),
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
                  backgroundColor: AppStyles.info,
                  child: Icon(Icons.sports_tennis, color: AppStyles.white),
                ),
                title: const Text('Novo Jogo'),
                subtitle: const Text('Organizar uma partida'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de organização de jogo
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
