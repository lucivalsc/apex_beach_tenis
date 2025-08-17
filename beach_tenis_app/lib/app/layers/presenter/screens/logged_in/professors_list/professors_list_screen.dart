import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../common/styles/app_styles.dart';
import '../../../../../common/widget/custom_app_bar.dart';
import '../../../../../common/widget/custom_button.dart';
import '../arena_dashboard/widgets/professor_list_item.dart';
import 'professors_list_provider.dart';

class ProfessorsListScreen extends StatefulWidget {
  const ProfessorsListScreen({Key? key}) : super(key: key);

  @override
  State<ProfessorsListScreen> createState() => _ProfessorsListScreenState();
}

class _ProfessorsListScreenState extends State<ProfessorsListScreen> {
  late ProfessorsListProvider _provider;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<ProfessorsListProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.loadProfessors();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Professores',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Consumer<ProfessorsListProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.professors.isEmpty) {
                  return _buildEmptyState();
                }

                return _buildProfessorsList(provider);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyles.primaryBlue,
        onPressed: () => _showAddProfessorDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(AppStyles.mediumSpace),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Buscar professor...',
          prefixIcon: const Icon(Icons.search, color: AppStyles.grey400),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
            borderSide: const BorderSide(color: AppStyles.grey200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
            borderSide: const BorderSide(color: AppStyles.grey200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
            borderSide: const BorderSide(color: AppStyles.primaryBlue),
          ),
        ),
        onChanged: (value) => _provider.filterProfessors(value),
      ),
    );
  }

  Widget _buildProfessorsList(ProfessorsListProvider provider) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppStyles.mediumSpace),
      itemCount: provider.filteredProfessors.length,
      itemBuilder: (context, index) {
        final professor = provider.filteredProfessors[index];
        return ProfessorListItem(
          name: professor.name,
          photoUrl: professor.photoUrl,
          specialty: professor.specialty,
          studentCount: professor.studentCount,
          onTap: () => _showProfessorDetails(context, professor),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off,
            size: 80,
            color: AppStyles.grey400.withOpacity(0.5),
          ),
          const SizedBox(height: AppStyles.mediumSpace),
          const Text(
            'Nenhum professor encontrado',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppStyles.grey600,
            ),
          ),
          const SizedBox(height: AppStyles.smallSpace),
          const Text(
            'Adicione professores à sua arena',
            style: TextStyle(
              fontSize: 14,
              color: AppStyles.grey500,
            ),
          ),
          const SizedBox(height: AppStyles.largeSpace),
          CustomButton(
            text: 'Adicionar Professor',
            onPressed: () => _showAddProfessorDialog(context),
            type: ButtonType.primary,
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppStyles.radiusLarge)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppStyles.mediumSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filtrar por',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppStyles.grey900,
                ),
              ),
              const SizedBox(height: AppStyles.mediumSpace),
              _buildFilterOption('Todos os professores', Icons.people, () {
                _provider.clearFilters();
                Navigator.pop(context);
              }),
              _buildFilterOption('Maior número de alunos', Icons.trending_up, () {
                _provider.sortByStudentCount(descending: true);
                Navigator.pop(context);
              }),
              _buildFilterOption('Menor número de alunos', Icons.trending_down, () {
                _provider.sortByStudentCount(descending: false);
                Navigator.pop(context);
              }),
              _buildFilterOption('Ordem alfabética', Icons.sort_by_alpha, () {
                _provider.sortByName();
                Navigator.pop(context);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppStyles.smallSpace),
        child: Row(
          children: [
            Icon(icon, color: AppStyles.primaryBlue),
            const SizedBox(width: AppStyles.mediumSpace),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: AppStyles.grey800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddProfessorDialog(BuildContext context) {
    // Implementação futura para adicionar professor
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Professor'),
        content: const Text('Funcionalidade a ser implementada.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showProfessorDetails(BuildContext context, Professor professor) {
    // Implementação futura para mostrar detalhes do professor
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(professor.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Especialidade: ${professor.specialty}'),
            Text('Alunos: ${professor.studentCount}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
