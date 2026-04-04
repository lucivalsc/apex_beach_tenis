import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/jogo_model.dart';
import 'package:apex_sports/app/layers/domain/usecases/jogo/create_jogo_usecase.dart';
import 'package:apex_sports/app/layers/domain/usecases/jogo/get_jogos_usecase.dart';
import 'package:flutter/material.dart';

class JogoProvider extends ChangeNotifier {
  final CreateJogoUsecase _createJogoUsecase;
  final GetJogosUsecase _getJogosUsecase;

  JogoProvider(
    this._createJogoUsecase,
    this._getJogosUsecase,
  );

  bool _isLoading = false;
  List<JogoModel> _jogos = [];
  String? _errorMessage;
  JogoModel? _selectedJogo;
  List<JogoModel> _filteredJogos = [];
  String _searchQuery = '';
  int? _selectedAtletaId;
  int? _selectedArenaId;

  bool get isLoading => _isLoading;
  List<JogoModel> get jogos => _jogos;
  String? get errorMessage => _errorMessage;
  JogoModel? get selectedJogo => _selectedJogo;
  List<JogoModel> get filteredJogos =>
      _filteredJogos.isEmpty && _searchQuery.isEmpty ? _jogos : _filteredJogos;
  String get searchQuery => _searchQuery;
  int? get selectedAtletaId => _selectedAtletaId;
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

  void setSelectedJogo(JogoModel? jogo) {
    _selectedJogo = jogo;
    notifyListeners();
  }

  void setSelectedAtletaId(int? atletaId) {
    _selectedAtletaId = atletaId;
    _applyFilters();
  }

  void setSelectedArenaId(int? arenaId) {
    _selectedArenaId = arenaId;
    _applyFilters();
  }

  void searchJogos(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = _jogos;

    // Filtro por atleta
    if (_selectedAtletaId != null) {
      filtered = filtered
          .where((j) =>
              j.atleta1Id == _selectedAtletaId ||
              j.atleta2Id == _selectedAtletaId ||
              j.atleta3Id == _selectedAtletaId ||
              j.atleta4Id == _selectedAtletaId)
          .toList();
    }

    // Filtro por arena
    if (_selectedArenaId != null) {
      filtered = filtered.where((j) => j.arenaId == _selectedArenaId).toList();
    }

    // Filtro por busca
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((jogo) {
        return jogo.nomeAtleta1
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            jogo.nomeAtleta2
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            (jogo.nomeAtleta3
                    ?.toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ??
                false) ||
            (jogo.nomeAtleta4
                    ?.toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ??
                false) ||
            (jogo.observacoes
                    ?.toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ??
                false);
      }).toList();
    }

    _filteredJogos = filtered;
    notifyListeners();
  }

  Future<void> getJogos() async {
    setLoading(true);
    clearError();

    final result = await _getJogosUsecase(NoParams());

    result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
      },
      (jogos) {
        _jogos = jogos;
        _applyFilters();
        setLoading(false);
      },
    );
  }

  Future<bool> createJogo(JogoModel jogo) async {
    setLoading(true);
    clearError();

    final result = await _createJogoUsecase(jogo);

    return result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
        return false;
      },
      (novoJogo) {
        _jogos.add(novoJogo);
        _applyFilters();
        setLoading(false);
        return true;
      },
    );
  }

  // Métodos específicos para jogos
  List<JogoModel> getJogosByAtleta(int atletaId) {
    return _jogos
        .where((j) =>
            j.atleta1Id == atletaId ||
            j.atleta2Id == atletaId ||
            j.atleta3Id == atletaId ||
            j.atleta4Id == atletaId)
        .toList();
  }

  List<JogoModel> getJogosByArena(int arenaId) {
    return _jogos.where((j) => j.arenaId == arenaId).toList();
  }

  List<JogoModel> getJogosByStatus(String status) {
    return _jogos.where((j) => j.status == status).toList();
  }

  List<JogoModel> getJogosEmAndamento() {
    return _jogos.where((j) => j.status == StatusJogo.emAndamento).toList();
  }

  List<JogoModel> getJogosFinalizados() {
    return _jogos.where((j) => j.status == StatusJogo.finalizado).toList();
  }

  List<JogoModel> getJogosPorPeriodo(DateTime inicio, DateTime fim) {
    return _jogos.where((j) {
      if (j.dataHora == null) return false;
      return j.dataHora!.isAfter(inicio.subtract(const Duration(days: 1))) &&
          j.dataHora!.isBefore(fim.add(const Duration(days: 1)));
    }).toList();
  }

  List<JogoModel> getHistoricoJogos(int atletaId, {int? limit}) {
    var jogosAtleta = getJogosByAtleta(atletaId);
    jogosAtleta =
        jogosAtleta.where((j) => j.status == StatusJogo.finalizado).toList();
    jogosAtleta.sort((a, b) =>
        (b.dataHora ?? DateTime.now()).compareTo(a.dataHora ?? DateTime.now()));

    if (limit != null && limit > 0) {
      return jogosAtleta.take(limit).toList();
    }

    return jogosAtleta;
  }

  Map<String, dynamic> getEstatisticasAtleta(int atletaId) {
    final jogosAtleta = getJogosByAtleta(atletaId)
        .where((j) => j.status == StatusJogo.finalizado)
        .toList();

    if (jogosAtleta.isEmpty) {
      return {
        'totalJogos': 0,
        'vitorias': 0,
        'derrotas': 0,
        'percentualVitorias': 0.0,
        'jogosSingles': 0,
        'jogosDuplas': 0,
      };
    }

    int vitorias = 0;
    int jogosSingles = 0;
    int jogosDuplas = 0;

    for (final jogo in jogosAtleta) {
      // Verifica se é singles ou duplas
      if (jogo.tipoJogo == TipoJogo.simples) {
        jogosSingles++;
      } else {
        jogosDuplas++;
      }

      // Conta vitórias (implementação simplificada)
      if (jogo.vencedorTime1) {
        // Time 1 venceu
        if (jogo.atleta1Id == atletaId || jogo.atleta3Id == atletaId) {
          vitorias++;
        }
      } else if (jogo.vencedorTime2) {
        // Time 2 venceu
        if (jogo.atleta2Id == atletaId || jogo.atleta4Id == atletaId) {
          vitorias++;
        }
      }
    }

    final derrotas = jogosAtleta.length - vitorias;
    final percentualVitorias =
        jogosAtleta.isNotEmpty ? (vitorias / jogosAtleta.length) * 100 : 0.0;

    return {
      'totalJogos': jogosAtleta.length,
      'vitorias': vitorias,
      'derrotas': derrotas,
      'percentualVitorias': percentualVitorias,
      'jogosSingles': jogosSingles,
      'jogosDuplas': jogosDuplas,
    };
  }

  Map<String, int> getEstatisticasPorStatus() {
    final stats = <String, int>{};
    for (final jogo in _jogos) {
      final statusKey = jogo.status.toString();
      stats[statusKey] = (stats[statusKey] ?? 0) + 1;
    }
    return stats;
  }

  double getPercentualJogosFinalizados() {
    if (_jogos.isEmpty) return 0.0;
    final finalizados =
        _jogos.where((j) => j.status == StatusJogo.finalizado).length;
    return (finalizados / _jogos.length) * 100;
  }

  void clearJogos() {
    _jogos.clear();
    _filteredJogos.clear();
    _selectedJogo = null;
    _searchQuery = '';
    _selectedAtletaId = null;
    _selectedArenaId = null;
    notifyListeners();
  }

  @override
  void dispose() {
    clearJogos();
    super.dispose();
  }
}
