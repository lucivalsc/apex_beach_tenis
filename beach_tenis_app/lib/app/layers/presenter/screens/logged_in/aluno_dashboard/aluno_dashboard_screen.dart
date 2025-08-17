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
import 'widgets/dashboard_card.dart';
import 'widgets/progresso_card.dart';
import 'widgets/treino_card.dart';

class AlunoDashboardScreen extends StatefulWidget {
  const AlunoDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AlunoDashboardScreen> createState() => _AlunoDashboardScreenState();

  static const String route = "aluno_dashboard";
}

class _AlunoDashboardScreenState extends State<AlunoDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Dados do usuário logado
  LoginModel? loginData;
  UsuarioModel? usuarioData;

  // Mock data para demonstração (usado como fallback)
  final Map<String, dynamic> alunoData = {
    'nome': 'Pedro Santos',
    'nivel': 'Intermediário',
    'professor': 'Carlos Silva',
    'arena': 'Apex Sports',
    'foto': null,
    'desde': '2023-05-15',
  };

  final List<Map<String, dynamic>> proximosTreinos = [
    {
      'data': '2023-11-15 14:00',
      'professor': 'Carlos Silva',
      'tipo': 'Técnica',
      'arena': 'Apex Sports',
      'status': 'CONFIRMADO',
    },
    {
      'data': '2023-11-18 10:30',
      'professor': 'Carlos Silva',
      'tipo': 'Fundamentos',
      'arena': 'Beach Tennis Club',
      'status': 'PENDENTE',
    },
    {
      'data': '2023-11-22 16:00',
      'professor': 'Ana Luiza',
      'tipo': 'Tática',
      'arena': 'Apex Sports',
      'status': 'CONFIRMADO',
    },
  ];

  final List<Map<String, dynamic>> progressoHabilidades = [
    {
      'habilidade': 'Saque',
      'progresso': 70,
      'ultimaAvaliacao': '2023-10-20',
    },
    {
      'habilidade': 'Voleio',
      'progresso': 60,
      'ultimaAvaliacao': '2023-10-20',
    },
    {
      'habilidade': 'Smash',
      'progresso': 45,
      'ultimaAvaliacao': '2023-10-20',
    },
    {
      'habilidade': 'Defesa',
      'progresso': 65,
      'ultimaAvaliacao': '2023-10-20',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Obter dados do usuário logado
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    loginData = authProvider.loginData;
    usuarioData = loginData?.usuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppStyles.primaryGreen,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppStyles.primaryGreen,
          statusBarIconBrightness: Brightness.light,
        ),
        title: Text(
          'ALUNO: ${usuarioData?.nome ?? alunoData['nome']}',
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
                _buildAlunoHeader(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildQuickActions(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildProximosTreinosSection(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildProgressoSection(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyles.primaryGreen,
        child: const Icon(Icons.add, color: AppStyles.white),
        onPressed: () {
          _showAddOptionsModal(context);
        },
      ),
    );
  }

  Widget _buildAlunoHeader() {
    final desde = DateTime.parse(alunoData['desde']);
    final desdeFormatter = DateFormat('dd/MM/yyyy');

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
                  backgroundColor: AppStyles.primaryGreen,
                  // Usando iniciais do usuário em vez de foto
                  child: Text(
                    usuarioData?.iniciais ?? alunoData['nome'].substring(0, 1).toUpperCase(),
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
                        usuarioData?.nome ?? alunoData['nome'],
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
                              color: AppStyles.primaryGreen,
                              borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                            ),
                            child: Text(
                              alunoData['nivel'],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppStyles.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Desde: ${desdeFormatter.format(desde)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppStyles.grey600,
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
                _buildStatItem('Professor', alunoData['professor'], Icons.school),
                _buildStatItem('Arena', alunoData['arena'], Icons.location_on),
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
        Icon(icon, color: AppStyles.primaryGreen, size: 20),
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
                subtitle: 'Ver agenda',
                color: AppStyles.primaryGreen,
                onTap: () {
                  // Navegar para tela de treinos
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.assessment,
                title: 'Progresso',
                subtitle: 'Minhas habilidades',
                color: AppStyles.primaryBlue,
                onTap: () {
                  // Navegar para tela de progresso
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
                icon: Icons.people,
                title: 'Professores',
                subtitle: 'Meus professores',
                color: AppStyles.warning,
                onTap: () {
                  // Navegar para tela de professores
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.location_on,
                title: 'Arenas',
                subtitle: 'Locais de treino',
                color: AppStyles.grey600,
                onTap: () {
                  // Navegar para tela de arenas
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
              professorNome: treino['professor'],
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

  Widget _buildProgressoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Meu Progresso',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppStyles.grey900,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para tela de progresso detalhado
              },
              child: const Text('Ver Detalhes'),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.smallSpace),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: progressoHabilidades.length,
          itemBuilder: (context, index) {
            final habilidade = progressoHabilidades[index];
            final ultimaAvaliacao = DateTime.parse(habilidade['ultimaAvaliacao']);
            final avaliacaoFormatter = DateFormat('dd/MM/yyyy');

            return ProgressoCard(
              habilidade: habilidade['habilidade'],
              progresso: habilidade['progresso'],
              ultimaAvaliacao: 'Última avaliação: ${avaliacaoFormatter.format(ultimaAvaliacao)}',
              onTap: () {
                // Navegar para detalhes da habilidade
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
              color: AppStyles.primaryGreen,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppStyles.white,
                  // Usando iniciais do usuário em vez de foto
                  child: Text(
                    usuarioData?.iniciais ?? alunoData['nome'].substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppStyles.primaryGreen,
                    ),
                  ),
                ),
                const SizedBox(height: AppStyles.smallSpace),
                Text(
                  usuarioData?.nome ?? alunoData['nome'],
                  style: const TextStyle(
                    color: AppStyles.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nível: ${alunoData['nivel']}',
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
            leading: const Icon(Icons.assessment),
            title: const Text('Meu Progresso'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de progresso
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Meus Professores'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de professores
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
                  backgroundColor: AppStyles.primaryGreen,
                  child: Icon(Icons.fitness_center, color: AppStyles.white),
                ),
                title: const Text('Agendar Treino'),
                subtitle: const Text('Marcar novo treino'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de agendamento de treino
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.warning,
                  child: Icon(Icons.people, color: AppStyles.white),
                ),
                title: const Text('Procurar Professor'),
                subtitle: const Text('Encontrar novo professor'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de busca de professores
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
