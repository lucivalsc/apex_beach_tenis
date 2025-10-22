import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/professor_model.dart';
import 'package:apex_sports/app/layers/domain/usecases/professor/create_professor_usecase.dart';
import 'package:apex_sports/app/layers/domain/usecases/professor/get_professores_usecase.dart';
import 'package:apex_sports/app/layers/domain/usecases/professor/update_professor_usecase.dart';
import 'package:apex_sports/app/layers/domain/usecases/professor/delete_professor_usecase.dart';
import 'package:flutter/material.dart';

class ProfessorProvider extends ChangeNotifier {
  final CreateProfessorUsecase _createProfessorUsecase;
  final GetProfessoresUsecase _getProfessoresUsecase;
  final UpdateProfessorUsecase _updateProfessorUsecase;
  final DeleteProfessorUsecase _deleteProfessorUsecase;

  ProfessorProvider(
    this._createProfessorUsecase,
    this._getProfessoresUsecase,
    this._updateProfessorUsecase,
    this._deleteProfessorUsecase,
  );

  bool _isLoading = false;
  List<ProfessorModel> _professores = [];
  String? _errorMessage;
  ProfessorModel? _selectedProfessor;
  List<ProfessorModel> _filteredProfessores = [];
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  List<ProfessorModel> get professores => _professores;
  String? get errorMessage => _errorMessage;
  ProfessorModel? get selectedProfessor => _selectedProfessor;
  List<ProfessorModel> get filteredProfessores => _filteredProfessores.isEmpty && _searchQuery.isEmpty ? _professores : _filteredProfessores;
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

  void setSelectedProfessor(ProfessorModel? professor) {
    _selectedProfessor = professor;
    notifyListeners();
  }

  void searchProfessores(String query) {
    _searchQuery = query;
    
    if (query.isEmpty) {
      _filteredProfessores = [];
    } else {
      _filteredProfessores = _professores.where((professor) {
        return professor.nome.toLowerCase().contains(query.toLowerCase()) ||
            professor.email.toLowerCase().contains(query.toLowerCase()) ||
            professor.cpf.contains(query) ||
            (professor.telefone?.contains(query) ?? false);
      }).toList();
    }
    
    notifyListeners();
  }

  Future<void> getProfessores() async {
    setLoading(true);
    clearError();

    final result = await _getProfessoresUsecase(NoParams());
    
    result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
      },
      (professores) {
        _professores = professores;
        if (_searchQuery.isNotEmpty) {
          searchProfessores(_searchQuery);
        }
        setLoading(false);
      },
    );
  }

  Future<bool> createProfessor(ProfessorModel professor) async {
    setLoading(true);
    clearError();

    final result = await _createProfessorUsecase(professor);
    
    return result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
        return false;
      },
      (novoProfessor) {
        _professores.add(novoProfessor);
        if (_searchQuery.isNotEmpty) {
          searchProfessores(_searchQuery);
        }
        setLoading(false);
        return true;
      },
    );
  }

  Future<bool> updateProfessor(ProfessorModel professor) async {
    setLoading(true);
    clearError();

    final result = await _updateProfessorUsecase(professor);
    
    return result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
        return false;
      },
      (professorAtualizado) {
        final index = _professores.indexWhere((p) => p.id == professorAtualizado.id);
        if (index != -1) {
          _professores[index] = professorAtualizado;
          if (_selectedProfessor?.id == professorAtualizado.id) {
            _selectedProfessor = professorAtualizado;
          }
          if (_searchQuery.isNotEmpty) {
            searchProfessores(_searchQuery);
          }
        }
        setLoading(false);
        return true;
      },
    );
  }

  Future<bool> deleteProfessor(int professorId) async {
    setLoading(true);
    clearError();

    final result = await _deleteProfessorUsecase(professorId);
    
    return result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
        return false;
      },
      (_) {
        _professores.removeWhere((p) => p.id == professorId);
        if (_selectedProfessor?.id == professorId) {
          _selectedProfessor = null;
        }
        if (_searchQuery.isNotEmpty) {
          searchProfessores(_searchQuery);
        }
        setLoading(false);
        return true;
      },
    );
  }

  Future<bool> ativarDesativarProfessor(int professorId, bool ativo) async {
    final professor = _professores.firstWhere((p) => p.id == professorId);
    final professorAtualizado = professor.copyWith(
      ativo: ativo,
      updatedAt: DateTime.now(),
    );
    return await updateProfessor(professorAtualizado);
  }

  List<ProfessorModel> getProfessoresAtivos() {
    return _professores.where((p) => p.ativo).toList();
  }

  List<ProfessorModel> getProfessoresPorArena(int arenaId) {
    return _professores.where((p) => p.arenasIds.contains(arenaId)).toList();
  }

  ProfessorModel? getProfessorById(int id) {
    try {
      return _professores.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  ProfessorModel? getProfessorByCpf(String cpf) {
    try {
      return _professores.firstWhere((p) => p.cpf == cpf);
    } catch (e) {
      return null;
    }
  }

  void clearProfessores() {
    _professores.clear();
    _filteredProfessores.clear();
    _selectedProfessor = null;
    _searchQuery = '';
    notifyListeners();
  }

  @override
  void dispose() {
    clearProfessores();
    super.dispose();
  }
}