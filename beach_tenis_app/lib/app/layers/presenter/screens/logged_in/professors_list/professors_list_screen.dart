// ignore_for_file: use_build_context_synchronously
import 'package:apex_sports/app/layers/presenter/providers/professor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../common/styles/app_styles.dart';
import '../../../../../common/widget/custom_app_bar.dart';
import '../../../../../common/widget/custom_button.dart';
import '../arena_dashboard/widgets/professor_list_item.dart';
import '../../../../data/models/professor_model.dart';
import 'widgets/add_professor_dialog.dart';

class ProfessorsListScreen extends StatefulWidget {
  const ProfessorsListScreen({Key? key}) : super(key: key);

  @override
  State<ProfessorsListScreen> createState() => _ProfessorsListScreenState();
}

class _ProfessorsListScreenState extends State<ProfessorsListScreen> {
  late ProfessorProvider _provider;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<ProfessorProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.getProfessores();
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
            child: Consumer<ProfessorProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.errorMessage != null) {
                  return _buildErrorState(provider.errorMessage!);
                }

                if (provider.professores.isEmpty) {
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
        onChanged: (value) => _provider.searchProfessores(value),
      ),
    );
  }

  Widget _buildProfessorsList(ProfessorProvider provider) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppStyles.mediumSpace),
      itemCount: provider.filteredProfessores.length,
      itemBuilder: (context, index) {
        final professor = provider.filteredProfessores[index];
        return ProfessorListItem(
          name: professor.nome,
          photoUrl: professor.foto,
          specialty: professor.especialidade ?? '',
          studentCount: professor.alunosIds.length,
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
            color: AppStyles.grey400.withValues(alpha: 0.5),
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

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: AppStyles.grey400.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppStyles.mediumSpace),
          const Text(
            'Erro ao carregar professores',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppStyles.grey600,
            ),
          ),
          const SizedBox(height: AppStyles.smallSpace),
          Text(
            error,
            style: const TextStyle(
              fontSize: 14,
              color: AppStyles.grey500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppStyles.largeSpace),
          CustomButton(
            text: 'Tentar Novamente',
            onPressed: () {
              _provider.clearError();
              _provider.getProfessores();
            },
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
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppStyles.radiusLarge)),
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
                _provider.searchProfessores('');
                Navigator.pop(context);
              }),
              _buildFilterOption('Apenas ativos', Icons.check_circle, () {
                // Implementação futura para filtrar apenas professores ativos
                Navigator.pop(context);
              }),
              _buildFilterOption('Ordem alfabética', Icons.sort_by_alpha, () {
                // Implementação futura para ordenação
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
    showDialog(
      context: context,
      builder: (context) => AddProfessorDialog(
        onSave: (professor) async {
          final success = await _provider.createProfessor(professor);
          if (success && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Professor adicionado com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }

  void _showProfessorDetails(BuildContext context, ProfessorModel professor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(professor.nome),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CPF: ${professor.cpfFormatado}'),
            Text('Email: ${professor.email}'),
            Text('Telefone: ${professor.telefoneFormatado}'),
            Text('Especialidade: ${professor.especialidade}'),
            Text('Alunos: ${professor.alunosIds.length}'),
            Text('Status: ${professor.ativo ? "Ativo" : "Inativo"}'),
          ],
        ),
        actions: [
          if (!professor.ativo)
            TextButton(
              onPressed: () {
                _provider.ativarDesativarProfessor(professor.id, true);
                Navigator.pop(context);
              },
              child: const Text('Ativar'),
            ),
          if (professor.ativo)
            TextButton(
              onPressed: () {
                _provider.ativarDesativarProfessor(professor.id, false);
                Navigator.pop(context);
              },
              child: const Text('Desativar'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
