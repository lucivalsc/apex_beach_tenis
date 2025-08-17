import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../../common/styles/app_styles.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../../common/widget/gradient_background.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/estatistica_card.dart';
import 'widgets/usuario_list_item.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();

  static const String route = "admin_dashboard";
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Mock data para demonstração
  final Map<String, dynamic> adminData = {
    'nome': 'Admin Master',
    'email': 'admin@beachtennis.com',
    'foto': null,
  };

  final Map<String, dynamic> estatisticas = {
    'usuarios': 156,
    'arenas': 8,
    'professores': 12,
    'atletas': 89,
    'alunos': 47,
    'profissionaisTecnicos': 5,
  };

  final List<Map<String, dynamic>> ultimosUsuarios = [
    {
      'nome': 'João Silva',
      'tipo': 'ATLETA',
      'email': 'joao.silva@email.com',
      'dataCadastro': '2023-11-10',
      'status': 'ATIVO',
      'foto': null,
    },
    {
      'nome': 'Maria Oliveira',
      'tipo': 'ALUNO',
      'email': 'maria.oliveira@email.com',
      'dataCadastro': '2023-11-08',
      'status': 'ATIVO',
      'foto': null,
    },
    {
      'nome': 'Carlos Santos',
      'tipo': 'PROFESSOR',
      'email': 'carlos.santos@email.com',
      'dataCadastro': '2023-11-05',
      'status': 'PENDENTE',
      'foto': null,
    },
    {
      'nome': 'Apex Sports',
      'tipo': 'ARENA',
      'email': 'contato@apexsports.com',
      'dataCadastro': '2023-11-01',
      'status': 'ATIVO',
      'foto': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppStyles.grey800,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppStyles.grey800,
          statusBarIconBrightness: Brightness.light,
        ),
        title: const Text(
          'ADMINISTRAÇÃO',
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
                _buildAdminHeader(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildQuickActions(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildEstatisticasSection(),
                const SizedBox(height: AppStyles.largeSpace),
                _buildUltimosUsuariosSection(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyles.grey800,
        child: const Icon(Icons.add, color: AppStyles.white),
        onPressed: () {
          _showAddOptionsModal(context);
        },
      ),
    );
  }

  Widget _buildAdminHeader() {
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
                  backgroundColor: AppStyles.grey800,
                  backgroundImage: adminData['foto'] != null
                      ? NetworkImage(adminData['foto'])
                      : null,
                  child: adminData['foto'] == null
                      ? Text(
                          adminData['nome'].substring(0, 1).toUpperCase(),
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
                        adminData['nome'],
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
                              color: AppStyles.grey800,
                              borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                            ),
                            child: const Text(
                              'ADMINISTRADOR',
                              style: TextStyle(
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
            const SizedBox(height: AppStyles.mediumSpace),
            const Divider(),
            const SizedBox(height: AppStyles.smallSpace),
            Row(
              children: [
                const Icon(Icons.email, size: 16, color: AppStyles.grey600),
                const SizedBox(width: 4),
                Text(
                  adminData['email'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppStyles.grey700,
                  ),
                ),
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
                title: 'Usuários',
                subtitle: 'Gerenciar usuários',
                color: AppStyles.grey800,
                onTap: () {
                  // Navegar para tela de usuários
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.location_on,
                title: 'Arenas',
                subtitle: 'Gerenciar arenas',
                color: AppStyles.primaryBlue,
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
                icon: Icons.settings,
                title: 'Configurações',
                subtitle: 'Sistema e app',
                color: AppStyles.warning,
                onTap: () {
                  // Navegar para tela de configurações
                },
              ),
            ),
            const SizedBox(width: AppStyles.mediumSpace),
            Expanded(
              child: DashboardCard(
                icon: Icons.assessment,
                title: 'Relatórios',
                subtitle: 'Dados do sistema',
                color: AppStyles.primaryGreen,
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

  Widget _buildEstatisticasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Estatísticas do Sistema',
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
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppStyles.smallSpace,
          crossAxisSpacing: AppStyles.smallSpace,
          childAspectRatio: 2.5,
          children: [
            EstatisticaCard(
              title: 'Usuários',
              value: estatisticas['usuarios'].toString(),
              icon: Icons.people,
              color: AppStyles.grey800,
            ),
            EstatisticaCard(
              title: 'Arenas',
              value: estatisticas['arenas'].toString(),
              icon: Icons.location_on,
              color: AppStyles.primaryBlue,
            ),
            EstatisticaCard(
              title: 'Professores',
              value: estatisticas['professores'].toString(),
              icon: Icons.school,
              color: AppStyles.primaryBlue,
            ),
            EstatisticaCard(
              title: 'Atletas',
              value: estatisticas['atletas'].toString(),
              icon: Icons.sports_tennis,
              color: AppStyles.primaryGreen,
            ),
            EstatisticaCard(
              title: 'Alunos',
              value: estatisticas['alunos'].toString(),
              icon: Icons.person,
              color: AppStyles.primaryGreen,
            ),
            EstatisticaCard(
              title: 'Prof. Técnicos',
              value: estatisticas['profissionaisTecnicos'].toString(),
              icon: Icons.medical_services,
              color: AppStyles.warning,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUltimosUsuariosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Últimos Usuários',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppStyles.grey900,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navegar para tela de todos os usuários
              },
              child: const Text('Ver Todos'),
            ),
          ],
        ),
        const SizedBox(height: AppStyles.smallSpace),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ultimosUsuarios.length,
          itemBuilder: (context, index) {
            final usuario = ultimosUsuarios[index];
            final dataCadastro = DateTime.parse(usuario['dataCadastro']);
            final cadastroFormatter = DateFormat('dd/MM/yyyy');
            
            return UsuarioListItem(
              name: usuario['nome'],
              photoUrl: usuario['foto'],
              type: usuario['tipo'],
              email: usuario['email'],
              cadastro: 'Cadastro: ${cadastroFormatter.format(dataCadastro)}',
              status: usuario['status'],
              onTap: () {
                // Navegar para detalhes do usuário
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
              color: AppStyles.grey800,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppStyles.white,
                  backgroundImage: adminData['foto'] != null
                      ? NetworkImage(adminData['foto'])
                      : null,
                  child: adminData['foto'] == null
                      ? Text(
                          adminData['nome'].substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppStyles.grey800,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: AppStyles.smallSpace),
                Text(
                  adminData['nome'],
                  style: const TextStyle(
                    color: AppStyles.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  adminData['email'],
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
            title: const Text('Usuários'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de usuários
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
          ListTile(
            leading: const Icon(Icons.assessment),
            title: const Text('Relatórios'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de relatórios
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de configurações
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Permissões'),
            onTap: () {
              Navigator.pop(context);
              // Navegar para tela de permissões
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
                  backgroundColor: AppStyles.grey800,
                  child: Icon(Icons.person_add, color: AppStyles.white),
                ),
                title: const Text('Novo Usuário'),
                subtitle: const Text('Adicionar usuário ao sistema'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de adição de usuário
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.primaryBlue,
                  child: Icon(Icons.add_location, color: AppStyles.white),
                ),
                title: const Text('Nova Arena'),
                subtitle: const Text('Cadastrar nova arena'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de cadastro de arena
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppStyles.primaryGreen,
                  child: Icon(Icons.assessment, color: AppStyles.white),
                ),
                title: const Text('Novo Relatório'),
                subtitle: const Text('Gerar relatório personalizado'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar para tela de geração de relatório
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
