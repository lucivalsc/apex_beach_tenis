import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../common/styles/app_styles.dart';
import '../../../../../common/widget/custom_app_bar.dart';
import 'statistics_provider.dart';
import 'widgets/stats_card.dart';
import 'widgets/stats_chart.dart';
import 'widgets/stats_filter.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> with SingleTickerProviderStateMixin {
  late StatisticsProvider _provider;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<StatisticsProvider>(context, listen: false);
    _tabController = TabController(length: 3, vsync: this);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.loadStatistics();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Estatísticas',
        showBackButton: true,
      ),
      body: Consumer<StatisticsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return Column(
            children: [
              _buildFilterSection(provider),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAlunosTab(provider),
                    _buildTreinosTab(provider),
                    _buildJogosTab(provider),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterSection(StatisticsProvider provider) {
    return StatsFilter(
      currentPeriod: provider.selectedPeriod,
      onPeriodChanged: (period) => provider.changeSelectedPeriod(period),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppStyles.primaryBlue,
        unselectedLabelColor: AppStyles.grey600,
        indicatorColor: AppStyles.primaryBlue,
        indicatorWeight: 3,
        tabs: const [
          Tab(text: 'Alunos'),
          Tab(text: 'Treinos'),
          Tab(text: 'Jogos'),
        ],
      ),
    );
  }

  Widget _buildAlunosTab(StatisticsProvider provider) {
    final alunosStats = provider.alunosStatistics;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppStyles.mediumSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Visão Geral',
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
                child: StatsCard(
                  title: 'Total de Alunos',
                  value: alunosStats.totalAlunos.toString(),
                  icon: Icons.people,
                  color: AppStyles.primaryBlue,
                ),
              ),
              const SizedBox(width: AppStyles.mediumSpace),
              Expanded(
                child: StatsCard(
                  title: 'Novos Alunos',
                  value: alunosStats.novosAlunos.toString(),
                  icon: Icons.person_add,
                  color: AppStyles.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppStyles.mediumSpace),
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'Alunos Ativos',
                  value: alunosStats.alunosAtivos.toString(),
                  icon: Icons.check_circle,
                  color: AppStyles.success,
                ),
              ),
              const SizedBox(width: AppStyles.mediumSpace),
              Expanded(
                child: StatsCard(
                  title: 'Alunos Inativos',
                  value: alunosStats.alunosInativos.toString(),
                  icon: Icons.cancel,
                  color: AppStyles.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppStyles.largeSpace),
          const Text(
            'Evolução de Alunos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppStyles.grey900,
            ),
          ),
          const SizedBox(height: AppStyles.mediumSpace),
          StatsChart(
            title: 'Crescimento de Alunos',
            data: alunosStats.evolucaoAlunos,
            color: AppStyles.primaryBlue,
          ),
          const SizedBox(height: AppStyles.largeSpace),
          const Text(
            'Distribuição por Gênero',
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
                child: StatsCard(
                  title: 'Masculino',
                  value: '${alunosStats.percentualMasculino}%',
                  icon: Icons.male,
                  color: AppStyles.primaryBlue,
                ),
              ),
              const SizedBox(width: AppStyles.mediumSpace),
              Expanded(
                child: StatsCard(
                  title: 'Feminino',
                  value: '${alunosStats.percentualFeminino}%',
                  icon: Icons.female,
                  color: Colors.pink,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTreinosTab(StatisticsProvider provider) {
    final treinosStats = provider.treinosStatistics;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppStyles.mediumSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Visão Geral',
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
                child: StatsCard(
                  title: 'Total de Treinos',
                  value: treinosStats.totalTreinos.toString(),
                  icon: Icons.fitness_center,
                  color: AppStyles.primaryBlue,
                ),
              ),
              const SizedBox(width: AppStyles.mediumSpace),
              Expanded(
                child: StatsCard(
                  title: 'Treinos Realizados',
                  value: treinosStats.treinosRealizados.toString(),
                  icon: Icons.check_circle,
                  color: AppStyles.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppStyles.mediumSpace),
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'Treinos Cancelados',
                  value: treinosStats.treinosCancelados.toString(),
                  icon: Icons.cancel,
                  color: AppStyles.warning,
                ),
              ),
              const SizedBox(width: AppStyles.mediumSpace),
              Expanded(
                child: StatsCard(
                  title: 'Média por Aluno',
                  value: treinosStats.mediaTreinosPorAluno.toString(),
                  icon: Icons.bar_chart,
                  color: AppStyles.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppStyles.largeSpace),
          const Text(
            'Evolução de Treinos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppStyles.grey900,
            ),
          ),
          const SizedBox(height: AppStyles.mediumSpace),
          StatsChart(
            title: 'Treinos por Semana',
            data: treinosStats.evolucaoTreinos,
            color: AppStyles.success,
          ),
          const SizedBox(height: AppStyles.largeSpace),
          const Text(
            'Distribuição por Tipo',
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
                child: StatsCard(
                  title: 'Individuais',
                  value: '${treinosStats.percentualIndividuais}%',
                  icon: Icons.person,
                  color: AppStyles.primaryBlue,
                ),
              ),
              const SizedBox(width: AppStyles.mediumSpace),
              Expanded(
                child: StatsCard(
                  title: 'Em Grupo',
                  value: '${treinosStats.percentualGrupo}%',
                  icon: Icons.groups,
                  color: AppStyles.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJogosTab(StatisticsProvider provider) {
    final jogosStats = provider.jogosStatistics;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppStyles.mediumSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Visão Geral',
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
                child: StatsCard(
                  title: 'Total de Jogos',
                  value: jogosStats.totalJogos.toString(),
                  icon: Icons.sports_tennis,
                  color: AppStyles.primaryBlue,
                ),
              ),
              const SizedBox(width: AppStyles.mediumSpace),
              Expanded(
                child: StatsCard(
                  title: 'Jogos Realizados',
                  value: jogosStats.jogosRealizados.toString(),
                  icon: Icons.check_circle,
                  color: AppStyles.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppStyles.mediumSpace),
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'Jogos Cancelados',
                  value: jogosStats.jogosCancelados.toString(),
                  icon: Icons.cancel,
                  color: AppStyles.warning,
                ),
              ),
              const SizedBox(width: AppStyles.mediumSpace),
              Expanded(
                child: StatsCard(
                  title: 'Média por Semana',
                  value: jogosStats.mediaJogosPorSemana.toString(),
                  icon: Icons.bar_chart,
                  color: AppStyles.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppStyles.largeSpace),
          const Text(
            'Evolução de Jogos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppStyles.grey900,
            ),
          ),
          const SizedBox(height: AppStyles.mediumSpace),
          StatsChart(
            title: 'Jogos por Semana',
            data: jogosStats.evolucaoJogos,
            color: Colors.orange,
          ),
          const SizedBox(height: AppStyles.largeSpace),
          const Text(
            'Distribuição por Tipo',
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
                child: StatsCard(
                  title: 'Simples',
                  value: '${jogosStats.percentualSimples}%',
                  icon: Icons.person,
                  color: AppStyles.primaryBlue,
                ),
              ),
              const SizedBox(width: AppStyles.mediumSpace),
              Expanded(
                child: StatsCard(
                  title: 'Duplas',
                  value: '${jogosStats.percentualDuplas}%',
                  icon: Icons.groups,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
