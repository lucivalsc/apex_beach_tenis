import 'package:flutter/material.dart';

import '../../../../../../common/styles/app_styles.dart';

class ProgressoCard extends StatelessWidget {
  final String habilidade;
  final int progresso;
  final String ultimaAvaliacao;
  final VoidCallback onTap;

  const ProgressoCard({
    Key? key,
    required this.habilidade,
    required this.progresso,
    required this.ultimaAvaliacao,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: AppStyles.mediumSpace),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppStyles.mediumSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getProgressoColor().withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                    ),
                    child: Icon(
                      _getHabilidadeIcon(),
                      color: _getProgressoColor(),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppStyles.mediumSpace),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habilidade,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppStyles.grey900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ultimaAvaliacao,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppStyles.grey600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '$progresso%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getProgressoColor(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppStyles.mediumSpace),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                child: LinearProgressIndicator(
                  value: progresso / 100,
                  backgroundColor: AppStyles.grey200,
                  color: _getProgressoColor(),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getHabilidadeIcon() {
    switch (habilidade) {
      case 'Saque':
        return Icons.sports_tennis;
      case 'Voleio':
        return Icons.sports_volleyball;
      case 'Smash':
        return Icons.sports_handball;
      case 'Defesa':
        return Icons.shield;
      default:
        return Icons.sports_tennis;
    }
  }

  Color _getProgressoColor() {
    if (progresso < 40) {
      return AppStyles.warning;
    } else if (progresso < 70) {
      return AppStyles.primaryGreen;
    } else {
      return AppStyles.primaryBlue;
    }
  }
}
