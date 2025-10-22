import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/treino_model.dart';
import 'package:apex_sports/app/layers/domain/usecases/treino/create_treino_usecase.dart';
import 'package:apex_sports/app/layers/domain/usecases/treino/get_treinos_usecase.dart';
import 'package:flutter/material.dart';

class TreinoProvider extends ChangeNotifier {
  final CreateTreinoUsecase _createTreinoUsecase;
  final GetTreinosUsecase _getTreinosUsecase;

  TreinoProvider(
    this._createTreinoUsecase,
    this._getTreinosUsecase,
  );

  bool _isLoading = false;
  List<TreinoModel> _treinos = [];
  String? _errorMessage;
  TreinoModel? _selectedTreino;
  List<TreinoModel> _filteredTreinos = [];
  String _searchQuery = '';
  int? _selectedAlunoId;
  int? _selectedProfessorId;
  int? _selectedArenaId;

  bool get isLoading => _isLoading;
  List<TreinoModel> get treinos => _treinos;
  String? get errorMessage => _errorMessage;
  TreinoModel? get selectedTreino => _selectedTreino;
  List<TreinoModel> get filteredTreinos => _filteredTreinos.isEmpty && _searchQuery.isEmpty ? _treinos : _filteredTreinos;
  String get searchQuery => _searchQuery;
  int? get selectedAlunoId => _selectedAlunoId;
  int? get selectedProfessorId => _selectedProfessorId;
  int? get selectedArenaId => _selectedArenaId;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void setSelectedTreino(TreinoModel? treino) {
    _selectedTreino = treino;
    notifyListeners();
  }

  void setSelectedAlunoId(int? alunoId) {
    _selectedAlunoId = alunoId;
    _applyFilters();
  }

  void setSelectedProfessorId(int? professorId) {
    _selectedProfessorId = professorId;
    _applyFilters();
  }

  void setSelectedArenaId(int? arenaId) {
    _selectedArenaId = arenaId;
    _applyFilters();
  }

  void searchTreinos(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = _treinos;

    // Filtro por aluno
    if (_selectedAlunoId != null) {
      filtered = filtered.where((t) => t.alunoId == _selectedAlunoId).toList();
    }

    // Filtro por professor
    if (_selectedProfessorId != null) {
      filtered = filtered.where((t) => t.professorId == _selectedProfessorId).toList();
    }

    // Filtro por arena
    if (_selectedArenaId != null) {
      filtered = filtered.where((t) => t.arenaId == _selectedArenaId).toList();
    }

    // Filtro por busca
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((treino) {
        return treino.nomeAluno.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            treino.nomeProfessor.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            treino.observacoes?.toLowerCase().contains(_searchQuery.toLowerCase()) == true;
      }).toList();
    }

    _filteredTreinos = filtered;
    notifyListeners();
  }

  Future<void> getTreinos() async {
    setLoading(true);
    clearError();

    final result = await _getTreinosUsecase(NoParams());
    
    result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
      },
      (treinos) {
        _treinos = treinos;
        _applyFilters();
        setLoading(false);
      },
    );
  }

  Future<bool> createTreino(TreinoModel treino) async {
    setLoading(true);
    clearError();

    final result = await _createTreinoUsecase(treino);
    
    return result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
        return false;
      },
      (novoTreino) {
        _treinos.add(novoTreino);
        _applyFilters();
        setLoading(false);
        return true;
      },
    );
  }

  // Métodos específicos para treinos
  List<TreinoModel> getTreinosByAluno(int alunoId) {
    return _treinos.where((t) => t.alunoId == alunoId).toList();
  }

  List<TreinoModel> getTreinosByProfessor(int professorId) {
    return _treinos.where((t) => t.professorId == professorId).toList();
  }

  List<TreinoModel> getTreinosByArena(int arenaId) {
    return _treinos.where((t) => t.arenaId == arenaId).toList();
  }

  List<TreinoModel> getTreinosByStatus(String status) {
    return _treinos.where((t) => t.status == status).toList();
  }

  List<TreinoModel> getTreinosNaoPreenchidos() {
    return _treinos.where((t) => !t.isPreenchido).toList();
  }

  List<TreinoModel> getTreinosPorPeriodo(DateTime inicio, DateTime fim) {
    return _treinos.where((t) {
      return t.data.isAfter(inicio.subtract(const Duration(days: 1))) &&
             t.data.isBefore(fim.add(const Duration(days: 1)));
    }).toList();
  }

  double getPercentualPreenchimento() {
    if (_treinos.isEmpty) return 0.0;
    final preenchidos = _treinos.where((t) => t.isPreenchido).length;
    return (preenchidos / _treinos.length) * 100;
  }

  double getPercentualPreenchimentoPorAluno(int alunoId) {
    final treinosAluno = getTreinosByAluno(alunoId);
    if (treinosAluno.isEmpty) return 0.0;
    final preenchidos = treinosAluno.where((t) => t.isPreenchido).length;
    return (preenchidos / treinosAluno.length) * 100;
  }

  double getPercentualPreenchimentoPorProfessor(int professorId) {
    final treinosProfessor = getTreinosByProfessor(professorId);
    if (treinosProfessor.isEmpty) return 0.0;
    final preenchidos = treinosProfessor.where((t) => t.isPreenchido).length;
    return (preenchidos / treinosProfessor.length) * 100;
  }

  Map<String, int> getEstatisticasPorStatus() {
    final stats = <String, int>{};
    for (final treino in _treinos) {
      final statusKey = treino.status.toString();
      stats[statusKey] = (stats[statusKey] ?? 0) + 1;
    }
    return stats;
  }

  void clearTreinos() {
    _treinos.clear();
    _filteredTreinos.clear();
    _selectedTreino = null;
    _searchQuery = '';
    _selectedAlunoId = null;
    _selectedProfessorId = null;
    _selectedArenaId = null;
    notifyListeners();
  }

  @override
  void dispose() {
    clearTreinos();
    super.dispose();
  }
}