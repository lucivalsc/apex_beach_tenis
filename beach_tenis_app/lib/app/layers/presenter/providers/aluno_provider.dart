import 'package:apex_sports/app/common/usecase.dart';
import 'package:apex_sports/app/layers/data/models/aluno_model.dart';
import 'package:apex_sports/app/layers/domain/usecases/aluno/create_aluno_usecase.dart';
import 'package:apex_sports/app/layers/domain/usecases/aluno/delete_aluno_usecase.dart';
import 'package:apex_sports/app/layers/domain/usecases/aluno/get_alunos_usecase.dart';
import 'package:apex_sports/app/layers/domain/usecases/aluno/update_aluno_usecase.dart';
import 'package:flutter/material.dart';

class AlunoProvider extends ChangeNotifier {
  final CreateAlunoUsecase _createAlunoUsecase;
  final GetAlunosUsecase _getAlunosUsecase;
  final UpdateAlunoUsecase _updateAlunoUsecase;
  final DeleteAlunoUsecase _deleteAlunoUsecase;

  AlunoProvider(
    this._createAlunoUsecase,
    this._getAlunosUsecase,
    this._updateAlunoUsecase,
    this._deleteAlunoUsecase,
  );

  bool _isLoading = false;
  List<AlunoModel> _alunos = [];
  String? _errorMessage;
  AlunoModel? _selectedAluno;
  List<AlunoModel> _filteredAlunos = [];
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  List<AlunoModel> get alunos => _alunos;
  String? get errorMessage => _errorMessage;
  AlunoModel? get selectedAluno => _selectedAluno;
  List<AlunoModel> get filteredAlunos => _filteredAlunos.isEmpty && _searchQuery.isEmpty ? _alunos : _filteredAlunos;
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

  void setSelectedAluno(AlunoModel? aluno) {
    _selectedAluno = aluno;
    notifyListeners();
  }

  void searchAlunos(String query) {
    _searchQuery = query;

    if (query.isEmpty) {
      _filteredAlunos = [];
    } else {
      _filteredAlunos = _alunos.where((aluno) {
        return aluno.nome.toLowerCase().contains(query.toLowerCase()) ||
            aluno.email.toLowerCase().contains(query.toLowerCase()) ||
            aluno.cpf.contains(query) ||
            aluno.telefone!.contains(query);
      }).toList();
    }

    notifyListeners();
  }

  Future<void> getAlunos() async {
    setLoading(true);
    clearError();

    final result = await _getAlunosUsecase(NoParams());

    result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
      },
      (alunos) {
        _alunos = alunos;
        if (_searchQuery.isNotEmpty) {
          searchAlunos(_searchQuery);
        }
        setLoading(false);
      },
    );
  }

  Future<bool> createAluno(AlunoModel aluno) async {
    setLoading(true);
    clearError();

    final result = await _createAlunoUsecase(aluno);

    return result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
        return false;
      },
      (novoAluno) {
        _alunos.add(novoAluno);
        if (_searchQuery.isNotEmpty) {
          searchAlunos(_searchQuery);
        }
        setLoading(false);
        return true;
      },
    );
  }

  Future<bool> updateAluno(AlunoModel aluno) async {
    setLoading(true);
    clearError();

    final result = await _updateAlunoUsecase(aluno);

    return result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
        return false;
      },
      (alunoAtualizado) {
        final index = _alunos.indexWhere((a) => a.id == alunoAtualizado.id);
        if (index != -1) {
          _alunos[index] = alunoAtualizado;
          if (_selectedAluno?.id == alunoAtualizado.id) {
            _selectedAluno = alunoAtualizado;
          }
          if (_searchQuery.isNotEmpty) {
            searchAlunos(_searchQuery);
          }
        }
        setLoading(false);
        return true;
      },
    );
  }

  Future<bool> deleteAluno(int alunoId) async {
    setLoading(true);
    clearError();

    final result = await _deleteAlunoUsecase(alunoId);

    return result.fold(
      (failure) {
        setError('${failure.title}: ${failure.message}');
        setLoading(false);
        return false;
      },
      (_) {
        _alunos.removeWhere((a) => a.id == alunoId);
        if (_selectedAluno?.id == alunoId) {
          _selectedAluno = null;
        }
        if (_searchQuery.isNotEmpty) {
          searchAlunos(_searchQuery);
        }
        setLoading(false);
        return true;
      },
    );
  }

  Future<bool> ativarDesativarAluno(int alunoId, bool ativo) async {
    final aluno = _alunos.firstWhere((a) => a.id == alunoId);
    final alunoAtualizado = aluno.copyWith(
      ativo: ativo,
      updatedAt: DateTime.now(),
    );
    return await updateAluno(alunoAtualizado);
  }

  Future<bool> atualizarNivelAluno(int alunoId, String novoNivel) async {
    final aluno = _alunos.firstWhere((a) => a.id == alunoId);
    final alunoAtualizado = aluno.copyWith(
      nivel: novoNivel,
      updatedAt: DateTime.now(),
    );
    return await updateAluno(alunoAtualizado);
  }

  List<AlunoModel> getAlunosAtivos() {
    return _alunos.where((a) => a.ativo).toList();
  }

  List<AlunoModel> getAlunosPorArena(int arenaId) {
    return _alunos.where((a) => a.arenaId == arenaId).toList();
  }

  List<AlunoModel> getAlunosPorProfessor(int professorId) {
    return _alunos.where((a) => a.professoresIds.contains(professorId)).toList();
  }

  List<AlunoModel> getAlunosPorNivel(String nivel) {
    return _alunos.where((a) => a.nivel == nivel).toList();
  }

  AlunoModel? getAlunoById(int id) {
    try {
      return _alunos.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  AlunoModel? getAlunoByCpf(String cpf) {
    try {
      return _alunos.firstWhere((a) => a.cpf == cpf);
    } catch (e) {
      return null;
    }
  }

  void clearAlunos() {
    _alunos.clear();
    _filteredAlunos.clear();
    _selectedAluno = null;
    _searchQuery = '';
    notifyListeners();
  }

  @override
  void dispose() {
    clearAlunos();
    super.dispose();
  }
}
