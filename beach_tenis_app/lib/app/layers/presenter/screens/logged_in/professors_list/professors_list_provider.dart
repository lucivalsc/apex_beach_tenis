import 'package:flutter/material.dart';

class Professor {
  final int id;
  final String name;
  final String? photoUrl;
  final String specialty;
  final int studentCount;
  final bool isActive;

  Professor({
    required this.id,
    required this.name,
    this.photoUrl,
    required this.specialty,
    required this.studentCount,
    this.isActive = true,
  });
}

class ProfessorsListProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<Professor> _professors = [];
  List<Professor> _filteredProfessors = [];
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  List<Professor> get professors => _professors;
  List<Professor> get filteredProfessors => _filteredProfessors;

  Future<void> loadProfessors() async {
    _isLoading = true;
    notifyListeners();

    // Simulando uma chamada de API com dados mockados
    await Future.delayed(const Duration(seconds: 1));

    _professors = [
      Professor(
        id: 1,
        name: 'Carlos Silva',
        specialty: 'Beach Tennis Avançado',
        studentCount: 15,
        photoUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      ),
      Professor(
        id: 2,
        name: 'Ana Oliveira',
        specialty: 'Técnica de Saque',
        studentCount: 12,
        photoUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      ),
      Professor(
        id: 3,
        name: 'Roberto Santos',
        specialty: 'Fundamentos',
        studentCount: 20,
        photoUrl: 'https://randomuser.me/api/portraits/men/67.jpg',
      ),
      Professor(
        id: 4,
        name: 'Juliana Costa',
        specialty: 'Beach Tennis Infantil',
        studentCount: 8,
        photoUrl: 'https://randomuser.me/api/portraits/women/33.jpg',
      ),
      Professor(
        id: 5,
        name: 'Marcos Pereira',
        specialty: 'Treinamento Físico',
        studentCount: 10,
        photoUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
      ),
      Professor(
        id: 6,
        name: 'Fernanda Lima',
        specialty: 'Técnica Avançada',
        studentCount: 18,
        photoUrl: 'https://randomuser.me/api/portraits/women/22.jpg',
      ),
    ];

    _filteredProfessors = List.from(_professors);
    _isLoading = false;
    notifyListeners();
  }

  void filterProfessors(String query) {
    _searchQuery = query.toLowerCase();
    
    if (_searchQuery.isEmpty) {
      _filteredProfessors = List.from(_professors);
    } else {
      _filteredProfessors = _professors
          .where((professor) =>
              professor.name.toLowerCase().contains(_searchQuery) ||
              professor.specialty.toLowerCase().contains(_searchQuery))
          .toList();
    }
    
    notifyListeners();
  }

  void sortByStudentCount({bool descending = true}) {
    _filteredProfessors.sort((a, b) {
      if (descending) {
        return b.studentCount.compareTo(a.studentCount);
      } else {
        return a.studentCount.compareTo(b.studentCount);
      }
    });
    notifyListeners();
  }

  void sortByName() {
    _filteredProfessors.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void clearFilters() {
    _filteredProfessors = List.from(_professors);
    notifyListeners();
  }

  Future<void> addProfessor(Professor professor) async {
    // Implementação futura para adicionar professor
    _professors.add(professor);
    _filteredProfessors = List.from(_professors);
    notifyListeners();
  }

  Future<void> updateProfessor(Professor professor) async {
    // Implementação futura para atualizar professor
    final index = _professors.indexWhere((p) => p.id == professor.id);
    if (index != -1) {
      _professors[index] = professor;
      _filteredProfessors = List.from(_professors);
      notifyListeners();
    }
  }

  Future<void> deleteProfessor(int id) async {
    // Implementação futura para excluir professor
    _professors.removeWhere((p) => p.id == id);
    _filteredProfessors = List.from(_professors);
    notifyListeners();
  }
}
