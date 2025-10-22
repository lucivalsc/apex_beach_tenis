import 'package:apex_sports/app/layers/data/models/atleta_model.dart';
import 'package:flutter/material.dart';

class AtletaProvider extends ChangeNotifier {
  bool _isLoading = false;
  final List<AtletaModel> _atletas = [];
  String? _errorMessage;
  AtletaModel? _selectedAtleta;
  List<AtletaModel> _filteredAtletas = [];
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  List<AtletaModel> get atletas => _atletas;
  String? get errorMessage => _errorMessage;
  AtletaModel? get selectedAtleta => _selectedAtleta;
  List<AtletaModel> get filteredAtletas =>
      _filteredAtletas.isEmpty && _searchQuery.isEmpty ? _atletas : _filteredAtletas;
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

  void setSelectedAtleta(AtletaModel? atleta) {
    _selectedAtleta = atleta;
    notifyListeners();
  }

  void searchAtletas(String query) {
    _searchQuery = query;

    if (query.isEmpty) {
      _filteredAtletas = [];
    } else {
      _filteredAtletas = _atletas.where((atleta) {
        return atleta.nome.toLowerCase().contains(query.toLowerCase()) ||
            atleta.email.toLowerCase().contains(query.toLowerCase()) ||
            atleta.cpf.contains(query) ||
            atleta.nivel!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  List<AtletaModel> getAtletasAtivos() {
    return _atletas.where((a) => a.ativo).toList();
  }

  List<AtletaModel> getAtletasPorNivel(String nivel) {
    return _atletas.where((a) => a.nivel == nivel).toList();
  }

  List<AtletaModel> getRankingGeral({int? limit}) {
    final atletasOrdenados = List<AtletaModel>.from(_atletas);
    atletasOrdenados.sort((a, b) => a.ranking!.compareTo(b.ranking!));

    if (limit != null && limit > 0) {
      return atletasOrdenados.take(limit).toList();
    }

    return atletasOrdenados;
  }

  AtletaModel? getAtletaById(int id) {
    try {
      return _atletas.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  AtletaModel? getAtletaByCpf(String cpf) {
    try {
      return _atletas.firstWhere((a) => a.cpf == cpf);
    } catch (e) {
      return null;
    }
  }

  void clearAtletas() {
    _atletas.clear();
    _filteredAtletas.clear();
    _selectedAtleta = null;
    _searchQuery = '';
    notifyListeners();
  }

  @override
  void dispose() {
    clearAtletas();
    super.dispose();
  }
}
