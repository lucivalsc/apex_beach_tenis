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
import 'widgets/atendimento_card.dart';
import 'widgets/atleta_card.dart';
import 'widgets/dashboard_card.dart';

class ProfissionalTecnicoDashboardScreen extends StatefulWidget {
  const ProfissionalTecnicoDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ProfissionalTecnicoDashboardScreen> createState() => _ProfissionalTecnicoDashboardScreenState();

  static const String route = "profissional_tecnico_dashboard";
}

class _ProfissionalTecnicoDashboardScreenState extends State<ProfissionalTecnicoDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Dados do usuário logado
  LoginModel? loginData;
  UsuarioModel? usuarioData;

  // Mock data para demonstração (usado como fallback)
  final Map<String, dynamic> profissionalData = {
    'nome': 'Ricardo Almeida',
    'especialidade': 'Fisioterapeuta Esportivo',
    'atletas': 15,
    'arenas': ['Apex Sports', 'Beach Tennis Club'],
    'foto': null,
    'avaliacao': 4.7,
  };

  final List<Map<String, dynamic>> proximosAtendimentos = [
    {
      'data': '2023-11-15 14:00',
      'atleta': 'João Silva',
      'tipo': 'Fisioterapia',
      'arena': 'Apex Sports',
      'status': 'CONFIRMADO',
      'observacao': 'Recuperação de lesão no ombro',
    },
    {
      'data': '2023-11-16 10:30',
      'atleta': 'Maria Oliveira',
      'tipo': 'Avaliação',
      'arena': 'Beach Tennis Club',
      'status': 'PENDENTE',
      'observacao': 'Primeira avaliação',
    },
    {
      'data': '2023-11-17 16:00',
      'atleta': 'Pedro Santos',
      'tipo': 'Fisioterapia',
      'arena': 'Apex Sports',
      'status': 'CONFIRMADO',
      'observacao': 'Sessão de recuperação',
    },
  ];

  final List<Map<String, dynamic>> atletasEmAtendimento = [
    {
      'nome': 'João Silva',
      'foto': null,
      'tipo': 'Atleta Profissional',
      'historico': 'Lesão no ombro',
      'ultimoAtendimento': '2023-11-10',
    },
    {
      'nome': 'Maria Oliveira',
      'foto': null,
      'tipo': 'Atleta Amador',
      'historico': 'Avaliação postural',
      'ultimoAtendimento': '2023-11-08',
    },
    {
      'nome': 'Pedro Santos',
      'foto': null,
      'tipo': 'Atleta Profissional',
      'historico': 'Recuperação muscular',
      'ultimoAtendimento': '2023-11-12',
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
        backgroundColor: AppStyles.warning,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppStyles.warning,
          statusBarIconBrightness: Brightness.light,
        ),
        title: Text(
          'PROF. TÉCNICO: ${usuarioData?.nome ?? profissionalData['nome']}',
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
                _buildProfissionalHeader(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildQuickActions(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildProximosAtendimentosSection(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildAtletasSection(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyles.warning,
        child: const Icon(Icons.add, color: AppStyles.white),
        onPressed: () {
          _showAddOptionsModal(context);
        },
      ),
    );
  }

  Widget _buildProfissionalHeader() {
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
                  backgroundColor: AppStyles.warning,
                  child: Text(
                    usuarioData != null 
                        ? usuarioData!.iniciais
                        : profissionalData['nome'].substring(0, 1).toUpperCase(),
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
                        usuarioData?.nome ?? profissionalData['nome'],
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
                              color: AppStyles.warning,
                              borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                            ),
                            child: Text(
                              profissionalData['especialidade'],
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
                                profissionalData['avaliacao'].toString(),
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
                _buildStatItem('Atletas', profissionalData['atletas'].toString(), Icons.people),
                _buildStatItem('Arenas', profissionalData['arenas'].length.toString(), Icons.location_on),
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
        Icon(icon, color: AppStyles.warning, size: 20),
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
                icon: Icons.calendar_today,
                title: 'Meus Atendimentos',
                subtitle: 'Gerenciar agenda',
                color: AppStyles.warning,
                onTap: () {
                  // Navegar para tela de atendimentos
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.people,
                title: 'Meus Atletas',
                subtitle: 'Gerenciar atletas',
                color: AppStyles.primaryBlue,
                onTap: () {
                  // Navegar para tela de atletas
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
                title: 'Relatórios',
                subtitle: 'Ver relatórios',
                color: AppStyles.primaryGreen,
                onTap: () {
                  // Navegar para tela de relatórios
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.location_on,
                title: 'Arenas',
                subtitle: 'Locais de atendimento',
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

  Widget _buildProximosAtendimentosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Próximos Atendimentos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppStyles.grey900,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para tela de todos os atendimentos
              },
              child: const Text('Ver Todos'),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.smallSpace),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: proximosAtendimentos.length,
          itemBuilder: (context, index) {
            final atendimento = proximosAtendimentos[index];
            final dateTime = DateTime.parse(atendimento['data']);
            final dateFormatter = DateFormat('dd/MM/yyyy');
            final timeFormatter = DateFormat('HH:mm');

            return AtendimentoCard(
              date: dateTime,
              formattedDate: dateFormatter.format(dateTime),
              formattedTime: timeFormatter.format(dateTime),
              atletaNome: atendimento['atleta'],
              tipo: atendimento['tipo'],
              arena: atendimento['arena'],
              status: atendimento['status'],
              observacao: atendimento['observacao'],
              onTap: () {
                // Navegar para detalhes do atendimento
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildAtletasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Meus Atletas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppStyles.grey900,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para tela de todos os atletas
              },
              child: const Text('Ver Todos'),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.smallSpace),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: atletasEmAtendimento.length,
          itemBuilder: (context, index) {
            final atleta = atletasEmAtendimento[index];
            final ultimoAtendimento = DateTime.parse(atleta['ultimoAtendimento']);
            final atendimentoFormatter = DateFormat('dd/MM/yyyy');

            return AtletaCard(
              name: atleta['nome'],
              photoUrl: atleta['foto'],
              type: atleta['tipo'],
              historico: atleta['historico'],
              ultimoAtendimento: 'Último atendimento: ${atendimentoFormatter.format(ultimoAtendimento)}',
              onTap: () {
                // Navegar para detalhes do atleta
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
              color: AppStyles.warning,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppStyles.white,
                  child: Text(
                    usuarioData != null 
                        ? usuarioData!.iniciais
                        : profissionalData['nome'].substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppStyles.warning,
                    ),
                  ),
                ),
                const SizedBox(height: AppStyles.smallSpace),
                Text(
                  usuarioData?.nome ?? profissionalData['nome'],
                  style: const TextStyle(
                    color: AppStyles.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profissionalData['especialidade'],
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
            leading: const Icon(Icons.calendar_today),
            title: const Text('Meus Atendimentos'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de atendimentos
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Meus Atletas'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de atletas
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
                  backgroundColor: AppStyles.warning,
                  child: Icon(Icons.calendar_today, color: AppStyles.white),
                ),
                title: const Text('Novo Atendimento'),
                subtitle: const Text('Agendar atendimento'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de agendamento
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.primaryBlue,
                  child: Icon(Icons.people, color: AppStyles.white),
                ),
                title: const Text('Novo Atleta'),
                subtitle: const Text('Adicionar atleta à lista'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de adição de atleta
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.primaryGreen,
                  child: Icon(Icons.assessment, color: AppStyles.white),
                ),
                title: const Text('Novo Relatório'),
                subtitle: const Text('Criar relatório de atleta'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de criação de relatório
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
