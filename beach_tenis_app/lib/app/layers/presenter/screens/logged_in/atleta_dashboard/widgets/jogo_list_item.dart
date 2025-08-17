import 'package:flutter/material.dart';

import '../../../../../../common/styles/app_styles.dart';

class JogoListItem extends StatelessWidget {
  final DateTime date;
  final String formattedDate;
  final String formattedTime;
  final String type;
  final String location;
  final List<dynamic> opponents;
  final String partner;
  final String status;
  final VoidCallback onTap;

  const JogoListItem({
    Key? key,
    required this.date,
    required this.formattedDate,
    required this.formattedTime,
    required this.type,
    required this.location,
    required this.opponents,
    required this.partner,
    required this.status,
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
                      color: _getTypeColor(),
                      borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                    ),
                    child: Text(
                      type,
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
                    location,
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
                    backgroundColor: AppStyles.lightBlue,
                    child: Icon(
                      Icons.person,
                      size: 14,
                      color: AppStyles.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Parceiro: $partner',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppStyles.grey800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppStyles.smallSpace),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: AppStyles.warning,
                    child: Icon(
                      Icons.people,
                      size: 14,
                      color: AppStyles.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Adversários: ${opponents.join(', ')}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppStyles.grey800,
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

  Color _getTypeColor() {
    switch (type) {
      case 'Amistoso':
        return AppStyles.primaryGreen;
      case 'Torneio':
        return AppStyles.primaryBlue;
      case 'Treino':
        return AppStyles.warning;
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
