import 'package:apex_sports/app/layers/data/models/arena_model.dart';
import 'package:flutter/material.dart';

class ArenaProvider extends ChangeNotifier {
  bool _isLoading = false;
  final List<ArenaModel> _arenas = [];
  String? _errorMessage;
  ArenaModel? _selectedArena;
  List<ArenaModel> _filteredArenas = [];
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  List<ArenaModel> get arenas => _arenas;
  String? get errorMessage => _errorMessage;
  ArenaModel? get selectedArena => _selectedArena;
  List<ArenaModel> get filteredArenas => _filteredArenas.isEmpty && _searchQuery.isEmpty ? _arenas : _filteredArenas;
  String get searchQuery => _searchQuery;

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

  void setSelectedArena(ArenaModel? arena) {
    _selectedArena = arena;
    notifyListeners();
  }

  void searchArenas(String query) {
    _searchQuery = query;

    if (query.isEmpty) {
      _filteredArenas = [];
    } else {
      _filteredArenas = _arenas.where((arena) {
        return arena.nome.toLowerCase().contains(query.toLowerCase()) ||
            arena.email.toLowerCase().contains(query.toLowerCase()) ||
            arena.cnpj.contains(query) ||
            arena.cidade!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  List<ArenaModel> getArenasAtivas() {
    return _arenas.where((a) => a.ativo).toList();
  }

  List<ArenaModel> getArenasByTipoAssinatura(String tipoAssinatura) {
    return _arenas.where((a) => a.tipoAssinatura == tipoAssinatura).toList();
  }

  List<ArenaModel> getArenasComPagamentoPendente() {
    return _arenas.where((a) => !a.isPagamentoEmDia).toList();
  }

  ArenaModel? getArenaById(int id) {
    try {
      return _arenas.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  ArenaModel? getArenaByCnpj(String cnpj) {
    try {
      return _arenas.firstWhere((a) => a.cnpj == cnpj);
    } catch (e) {
      return null;
    }
  }

  void clearArenas() {
    _arenas.clear();
    _filteredArenas.clear();
    _selectedArena = null;
    _searchQuery = '';
    notifyListeners();
  }

  @override
  void dispose() {
    clearArenas();
    super.dispose();
  }
}
