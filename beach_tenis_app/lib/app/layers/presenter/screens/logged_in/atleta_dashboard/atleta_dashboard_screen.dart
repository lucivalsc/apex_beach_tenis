import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../../common/styles/app_styles.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../../common/widget/gradient_background.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/estatistica_card.dart';
import 'widgets/jogo_list_item.dart';

class AtletaDashboardScreen extends StatefulWidget {
  const AtletaDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AtletaDashboardScreen> createState() => _AtletaDashboardScreenState();

  static const String route = "atleta_dashboard";
}

class _AtletaDashboardScreenState extends State<AtletaDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Mock data para demonstração
  final Map<String, dynamic> atletaData = {
    'nome': 'João Silva',
    'nivel': 'Intermediário',
    'pontuacao': 780,
    'ranking': 12,
    'jogos_totais': 48,
    'vitorias': 32,
    'derrotas': 16,
    'foto': null,
  };

  final List<Map<String, dynamic>> proximosJogos = [
    {
      'data': '2023-11-15 16:00',
      'tipo': 'Amistoso',
      'local': 'Arena Beach Tennis',
      'adversarios': ['Pedro Almeida', 'Carlos Santos'],
      'parceiro': 'Ana Oliveira',
      'status': 'CONFIRMADO',
    },
    {
      'data': '2023-11-18 10:30',
      'tipo': 'Torneio',
      'local': 'Clube Praia Grande',
      'adversarios': ['Roberto Mendes', 'Marcelo Lima'],
      'parceiro': 'Ana Oliveira',
      'status': 'PENDENTE',
    },
    {
      'data': '2023-11-22 14:00',
      'tipo': 'Treino',
      'local': 'Arena Beach Tennis',
      'adversarios': ['Luiz Costa', 'Fernando Gomes'],
      'parceiro': 'Paulo Ribeiro',
      'status': 'CONFIRMADO',
    },
  ];

  final Map<String, dynamic> estatisticas = {
    'vitorias_recentes': 7,
    'derrotas_recentes': 3,
    'melhor_pontuacao': 12,
    'media_pontos': 8.5,
    'jogos_mes': 10,
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
        title: Text(
          atletaData['nome'],
          style: const TextStyle(
            color: AppStyles.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: AppStyles.white),
                onPressed: () {
                  // Navegar para tela de notificações
                },
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppStyles.warning,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: AppStyles.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
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
                _buildAtletaHeader(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildQuickActions(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildEstatisticasSection(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildProximosJogosSection(),
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

  Widget _buildAtletaHeader() {
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
                  backgroundImage: atletaData['foto'] != null
                      ? NetworkImage(atletaData['foto'])
                      : null,
                  child: atletaData['foto'] == null
                      ? Text(
                          atletaData['nome'].substring(0, 1).toUpperCase(),
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
                        atletaData['nome'],
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
                              atletaData['nivel'],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppStyles.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Ranking: #${atletaData['ranking']}',
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Pontuação', atletaData['pontuacao'].toString(), Icons.star),
                _buildStatItem('Jogos', atletaData['jogos_totais'].toString(), Icons.sports_tennis),
                _buildStatItem('Vitórias', atletaData['vitorias'].toString(), Icons.emoji_events),
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
                icon: Icons.insert_chart,
                title: 'Minhas Estatísticas',
                subtitle: 'Ver desempenho',
                color: AppStyles.primaryBlue,
                onTap: () {
                  // Navegar para tela de estatísticas
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.add_circle,
                title: 'Adicionar Jogo',
                subtitle: 'Registrar partida',
                color: AppStyles.grey600,
                onTap: () {
                  // Navegar para tela de adicionar jogo
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
                icon: Icons.list,
                title: 'Listar Jogos',
                subtitle: 'Histórico completo',
                color: AppStyles.grey600,
                onTap: () {
                  // Navegar para tela de listar jogos
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.swap_horiz,
                title: 'Alternar Perfil',
                subtitle: 'Mudar de perfil',
                color: AppStyles.primaryBlue,
                onTap: () {
                  // Navegar para tela de seleção de perfil
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEstatisticasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Estatísticas Recentes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppStyles.grey900,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para tela de estatísticas detalhadas
              },
              child: const Text('Ver Detalhes'),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.smallSpace),
        Row(
          children: [
            Expanded(
              child: EstatisticaCard(
                title: 'Vitórias',
                value: estatisticas['vitorias_recentes'].toString(),
                icon: Icons.emoji_events,
                color: AppStyles.success,
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: EstatisticaCard(
                title: 'Derrotas',
                value: estatisticas['derrotas_recentes'].toString(),
                icon: Icons.close,
                color: AppStyles.error,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.mediumSpace),
        Row(
          children: [
            Expanded(
              child: EstatisticaCard(
                title: 'Melhor Pontuação',
                value: estatisticas['melhor_pontuacao'].toString(),
                icon: Icons.star,
                color: AppStyles.warning,
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: EstatisticaCard(
                title: 'Média de Pontos',
                value: estatisticas['media_pontos'].toString(),
                icon: Icons.analytics,
                color: AppStyles.info,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProximosJogosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Próximos Jogos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppStyles.grey900,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para tela de todos os jogos
              },
              child: const Text('Ver Todos'),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.smallSpace),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: proximosJogos.length,
          itemBuilder: (context, index) {
            final jogo = proximosJogos[index];
            final dateTime = DateTime.parse(jogo['data']);
            final dateFormatter = DateFormat('dd/MM/yyyy');
            final timeFormatter = DateFormat('HH:mm');
            
            return JogoListItem(
              date: dateTime,
              formattedDate: dateFormatter.format(dateTime),
              formattedTime: timeFormatter.format(dateTime),
              type: jogo['tipo'],
              location: jogo['local'],
              opponents: jogo['adversarios'],
              partner: jogo['parceiro'],
              status: jogo['status'],
              onTap: () {
                // Navegar para detalhes do jogo
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
                  backgroundImage: atletaData['foto'] != null
                      ? NetworkImage(atletaData['foto'])
                      : null,
                  child: atletaData['foto'] == null
                      ? Text(
                          atletaData['nome'].substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppStyles.primaryBlue,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: AppStyles.smallSpace),
                Text(
                  atletaData['nome'],
                  style: const TextStyle(
                    color: AppStyles.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nível: ${atletaData['nivel']}',
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
            leading: const Icon(Icons.insert_chart),
            title: const Text('Minhas Estatísticas'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de estatísticas
            },
          ),
          ListTile(
            leading: const Icon(Icons.sports_tennis),
            title: const Text('Meus Jogos'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de jogos
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Amigos'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de amigos
            },
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Torneios'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de torneios
            },
          ),
          ListTile(
            leading: const Icon(Icons.swap_horiz),
            title: const Text('Alternar Perfil'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de seleção de perfil
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
                  child: Icon(Icons.sports_tennis, color: AppStyles.white),
                ),
                title: const Text('Novo Jogo'),
                subtitle: const Text('Registrar uma nova partida'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de registro de jogo
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.primaryGreen,
                  child: Icon(Icons.people, color: AppStyles.white),
                ),
                title: const Text('Adicionar Amigo'),
                subtitle: const Text('Conectar-se com outro atleta'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de adicionar amigo
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.warning,
                  child: Icon(Icons.event, color: AppStyles.white),
                ),
                title: const Text('Inscrever-se em Torneio'),
                subtitle: const Text('Participar de competição'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de torneios
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
