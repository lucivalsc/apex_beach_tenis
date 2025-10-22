import 'package:apex_sports/app/layers/presenter/providers/aluno_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../common/styles/app_styles.dart';
import '../../../../../common/widget/custom_app_bar.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../data/models/aluno_model.dart';
import 'widgets/add_aluno_dialog.dart';
import 'widgets/aluno_list_item.dart';

class AlunosListScreen extends StatefulWidget {
  const AlunosListScreen({Key? key}) : super(key: key);

  @override
  State<AlunosListScreen> createState() => _AlunosListScreenState();
}

class _AlunosListScreenState extends State<AlunosListScreen> {
  late AlunoProvider _provider;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<AlunoProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.getAlunos();
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
        title: 'Alunos',
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
            child: Consumer<AlunoProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.errorMessage != null) {
                  return _buildErrorState(provider.errorMessage!);
                }

                if (provider.alunos.isEmpty) {
                  return _buildEmptyState();
                }

                return _buildAlunosList(provider);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyles.primaryBlue,
        onPressed: () => _showAddAlunoDialog(context),
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
          hintText: 'Buscar aluno...',
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
        onChanged: (value) => _provider.searchAlunos(value),
      ),
    );
  }

  Widget _buildAlunosList(AlunoProvider provider) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppStyles.mediumSpace),
      itemCount: provider.filteredAlunos.length,
      itemBuilder: (context, index) {
        final aluno = provider.filteredAlunos[index];
        return AlunoListItem(
          aluno: aluno,
          onTap: () => _showAlunoDetails(context, aluno),
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
            Icons.school_outlined,
            size: 80,
            color: AppStyles.grey400.withOpacity(0.5),
          ),
          const SizedBox(height: AppStyles.mediumSpace),
          const Text(
            'Nenhum aluno encontrado',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppStyles.grey600,
            ),
          ),
          const SizedBox(height: AppStyles.smallSpace),
          const Text(
            'Adicione alunos à sua arena',
            style: TextStyle(
              fontSize: 14,
              color: AppStyles.grey500,
            ),
          ),
          const SizedBox(height: AppStyles.largeSpace),
          CustomButton(
            text: 'Adicionar Aluno',
            onPressed: () => _showAddAlunoDialog(context),
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
            color: AppStyles.grey400.withOpacity(0.5),
          ),
          const SizedBox(height: AppStyles.mediumSpace),
          const Text(
            'Erro ao carregar alunos',
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
              _provider.getAlunos();
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
              _buildFilterOption('Todos os alunos', Icons.people, () {
                _provider.searchAlunos('');
                Navigator.pop(context);
              }),
              _buildFilterOption('Apenas ativos', Icons.check_circle, () {
                Navigator.pop(context);
              }),
              _buildFilterOption('Nível Iniciante', Icons.star_border, () {
                Navigator.pop(context);
              }),
              _buildFilterOption('Nível Intermediário', Icons.star_half, () {
                Navigator.pop(context);
              }),
              _buildFilterOption('Nível Avançado', Icons.star, () {
                Navigator.pop(context);
              }),
              _buildFilterOption('Ordem alfabética', Icons.sort_by_alpha, () {
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

  void _showAddAlunoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddAlunoDialog(
        onSave: (aluno) async {
          final success = await _provider.createAluno(aluno);
          if (success && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Aluno adicionado com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }

  void _showAlunoDetails(BuildContext context, AlunoModel aluno) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(aluno.nome),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CPF: ${aluno.cpfFormatado}'),
              const SizedBox(height: 8),
              Text('Email: ${aluno.email}'),
              const SizedBox(height: 8),
              Text('Telefone: ${aluno.telefoneFormatado}'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('Nível: ${aluno.nivel}'),
                  const SizedBox(width: 8),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Color(
                          int.parse('0xFF${aluno.corNivel.substring(1)}')),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Idade: ${aluno.idade} anos'),
              const SizedBox(height: 8),
              Text('Professores: ${aluno.professoresIds.length}'),
              const SizedBox(height: 8),
              Text('Status: ${aluno.ativo ? "Ativo" : "Inativo"}'),
              if (aluno.bio != null) ...[
                const SizedBox(height: 8),
                Text('Bio: ${aluno.bio}'),
              ],
            ],
          ),
        ),
        actions: [
          if (!aluno.ativo)
            TextButton(
              onPressed: () {
                _provider.ativarDesativarAluno(aluno.id, true);
                Navigator.pop(context);
              },
              child: const Text('Ativar'),
            ),
          if (aluno.ativo)
            TextButton(
              onPressed: () {
                _provider.ativarDesativarAluno(aluno.id, false);
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
