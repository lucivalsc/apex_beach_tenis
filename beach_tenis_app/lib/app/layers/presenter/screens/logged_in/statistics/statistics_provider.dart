import 'package:flutter/material.dart';

enum StatisticsPeriod {
  day,
  week,
  month,
  year,
}

class AlunosStatistics {
  final int totalAlunos;
  final int novosAlunos;
  final int alunosAtivos;
  final int alunosInativos;
  final int percentualMasculino;
  final int percentualFeminino;
  final List<Map<String, dynamic>> evolucaoAlunos;

  AlunosStatistics({
    required this.totalAlunos,
    required this.novosAlunos,
    required this.alunosAtivos,
    required this.alunosInativos,
    required this.percentualMasculino,
    required this.percentualFeminino,
    required this.evolucaoAlunos,
  });
}

class TreinosStatistics {
  final int totalTreinos;
  final int treinosRealizados;
  final int treinosCancelados;
  final double mediaTreinosPorAluno;
  final int percentualIndividuais;
  final int percentualGrupo;
  final List<Map<String, dynamic>> evolucaoTreinos;

  TreinosStatistics({
    required this.totalTreinos,
    required this.treinosRealizados,
    required this.treinosCancelados,
    required this.mediaTreinosPorAluno,
    required this.percentualIndividuais,
    required this.percentualGrupo,
    required this.evolucaoTreinos,
  });
}

class JogosStatistics {
  final int totalJogos;
  final int jogosRealizados;
  final int jogosCancelados;
  final double mediaJogosPorSemana;
  final int percentualSimples;
  final int percentualDuplas;
  final List<Map<String, dynamic>> evolucaoJogos;

  JogosStatistics({
    required this.totalJogos,
    required this.jogosRealizados,
    required this.jogosCancelados,
    required this.mediaJogosPorSemana,
    required this.percentualSimples,
    required this.percentualDuplas,
    required this.evolucaoJogos,
  });
}

class StatisticsProvider extends ChangeNotifier {
  bool _isLoading = false;
  StatisticsPeriod _selectedPeriod = StatisticsPeriod.month;
  
  late AlunosStatistics _alunosStatistics;
  late TreinosStatistics _treinosStatistics;
  late JogosStatistics _jogosStatistics;

  bool get isLoading => _isLoading;
  StatisticsPeriod get selectedPeriod => _selectedPeriod;
  AlunosStatistics get alunosStatistics => _alunosStatistics;
  TreinosStatistics get treinosStatistics => _treinosStatistics;
  JogosStatistics get jogosStatistics => _jogosStatistics;

  StatisticsProvider() {
    _initializeWithMockData();
  }

  void _initializeWithMockData() {
    // Mock data para alunos
    _alunosStatistics = AlunosStatistics(
      totalAlunos: 120,
      novosAlunos: 15,
      alunosAtivos: 98,
      alunosInativos: 22,
      percentualMasculino: 65,
      percentualFeminino: 35,
      evolucaoAlunos: [
        {'data': 'Jan', 'valor': 80},
        {'data': 'Fev', 'valor': 85},
        {'data': 'Mar', 'valor': 90},
        {'data': 'Abr', 'valor': 95},
        {'data': 'Mai', 'valor': 105},
        {'data': 'Jun', 'valor': 120},
      ],
    );

    // Mock data para treinos
    _treinosStatistics = TreinosStatistics(
      totalTreinos: 450,
      treinosRealizados: 420,
      treinosCancelados: 30,
      mediaTreinosPorAluno: 3.5,
      percentualIndividuais: 40,
      percentualGrupo: 60,
      evolucaoTreinos: [
        {'data': 'Sem 1', 'valor': 65},
        {'data': 'Sem 2', 'valor': 70},
        {'data': 'Sem 3', 'valor': 68},
        {'data': 'Sem 4', 'valor': 75},
        {'data': 'Sem 5', 'valor': 80},
        {'data': 'Sem 6', 'valor': 85},
      ],
    );

    // Mock data para jogos
    _jogosStatistics = JogosStatistics(
      totalJogos: 220,
      jogosRealizados: 200,
      jogosCancelados: 20,
      mediaJogosPorSemana: 8.5,
      percentualSimples: 30,
      percentualDuplas: 70,
      evolucaoJogos: [
        {'data': 'Sem 1', 'valor': 30},
        {'data': 'Sem 2', 'valor': 35},
        {'data': 'Sem 3', 'valor': 32},
        {'data': 'Sem 4', 'valor': 40},
        {'data': 'Sem 5', 'valor': 38},
        {'data': 'Sem 6', 'valor': 45},
      ],
    );
  }

  Future<void> loadStatistics() async {
    _isLoading = true;
    notifyListeners();

    // Simulando uma chamada de API
    await Future.delayed(const Duration(seconds: 1));
    
    // Aqui seria feita a chamada real para obter os dados
    // Por enquanto, usamos os dados mock já inicializados
    
    _isLoading = false;
    notifyListeners();
  }

  void changeSelectedPeriod(StatisticsPeriod period) async {
    if (_selectedPeriod != period) {
      _selectedPeriod = period;
      await loadStatistics();
    }
  }

  // Nota: Métodos para carregar estatísticas específicas por período serão
  // implementados quando houver integração com backend
}
