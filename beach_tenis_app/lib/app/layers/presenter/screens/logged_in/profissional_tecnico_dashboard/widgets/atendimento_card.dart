import 'package:flutter/material.dart';

import '../../../../../../common/styles/app_styles.dart';

class AtendimentoCard extends StatelessWidget {
  final DateTime date;
  final String formattedDate;
  final String formattedTime;
  final String atletaNome;
  final String tipo;
  final String arena;
  final String status;
  final String observacao;
  final VoidCallback onTap;

  const AtendimentoCard({
    Key? key,
    required this.date,
    required this.formattedDate,
    required this.formattedTime,
    required this.atletaNome,
    required this.tipo,
    required this.arena,
    required this.status,
    required this.observacao,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getTipoColor(),
                      borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                    ),
                    child: Text(
                      tipo,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppStyles.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(),
                      borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppStyles.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppStyles.smallSpace),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: AppStyles.grey600),
                  const SizedBox(width: 4),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppStyles.grey800,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.access_time, size: 16, color: AppStyles.grey600),
                  const SizedBox(width: 4),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppStyles.grey800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppStyles.smallSpace),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: AppStyles.grey600),
                  const SizedBox(width: 4),
                  Text(
                    arena,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppStyles.grey700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppStyles.smallSpace),
              const Divider(),
              const SizedBox(height: AppStyles.smallSpace),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: AppStyles.primaryBlue,
                    child: Icon(
                      Icons.person,
                      size: 14,
                      color: AppStyles.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Atleta: $atletaNome',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppStyles.grey800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppStyles.smallSpace),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.notes, size: 16, color: AppStyles.grey600),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      observacao,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppStyles.grey700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTipoColor() {
    switch (tipo) {
      case 'Fisioterapia':
        return AppStyles.warning;
      case 'Avaliação':
        return AppStyles.primaryBlue;
      case 'Recuperação':
        return AppStyles.primaryGreen;
      default:
        return AppStyles.grey600;
    }
  }

  Color _getStatusColor() {
    switch (status) {
      case 'CONFIRMADO':
        return AppStyles.success;
      case 'PENDENTE':
        return AppStyles.warning;
      case 'CANCELADO':
        return AppStyles.error;
      default:
        return AppStyles.grey600;
    }
  }
}
