import 'package:flutter/material.dart';
import '../../../../../../common/styles/app_styles.dart';
import '../../../../../data/models/aluno_model.dart';

class AlunoListItem extends StatelessWidget {
  final AlunoModel aluno;
  final VoidCallback onTap;

  const AlunoListItem({
    Key? key,
    required this.aluno,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppStyles.mediumSpace),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppStyles.mediumSpace),
          child: Row(
            children: [
              // Avatar do aluno
              CircleAvatar(
                radius: 25,
                backgroundColor: AppStyles.primaryBlue.withValues(alpha: 0.1),
                backgroundImage:
                    aluno.foto != null ? NetworkImage(aluno.foto!) : null,
                child: aluno.foto == null
                    ? const Icon(
                        Icons.person,
                        color: AppStyles.primaryBlue,
                        size: 30,
                      )
                    : null,
              ),
              const SizedBox(width: AppStyles.mediumSpace),

              // Informações do aluno
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome do aluno
                    Text(
                      aluno.nome,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppStyles.grey900,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Nível com cor
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Color(int.parse(
                                '0xFF${aluno.corNivel.substring(1)}')),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          aluno.nivel ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppStyles.grey600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Idade e professores
                    Row(
                      children: [
                        const Icon(
                          Icons.cake,
                          size: 14,
                          color: AppStyles.grey500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${aluno.idade} anos',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppStyles.grey500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.person,
                          size: 14,
                          color: AppStyles.grey500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${aluno.professoresIds.length} prof.',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppStyles.grey500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Status e ações
              Column(
                children: [
                  // Status do aluno
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: aluno.ativo
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      aluno.ativo ? 'Ativo' : 'Inativo',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: aluno.ativo ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Botão de detalhes
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppStyles.grey400,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
