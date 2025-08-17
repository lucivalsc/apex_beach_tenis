import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../common/styles/app_styles.dart';

class UpcomingEventCard extends StatelessWidget {
  final String type;
  final DateTime date;
  final String title;
  final String subtitle;
  final String status;
  final VoidCallback? onTap;

  const UpcomingEventCard({
    Key? key,
    required this.type,
    required this.date,
    required this.title,
    required this.subtitle,
    required this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd/MM');
    final timeFormatter = DateFormat('HH:mm');
    
    Color typeColor;
    IconData typeIcon;
    
    switch (type) {
      case 'TREINO':
        typeColor = AppStyles.primaryGreen;
        typeIcon = Icons.fitness_center;
        break;
      case 'JOGO':
        typeColor = AppStyles.warning;
        typeIcon = Icons.sports_tennis;
        break;
      case 'AVALIAÇÃO':
        typeColor = AppStyles.info;
        typeIcon = Icons.assessment;
        break;
      default:
        typeColor = AppStyles.primaryBlue;
        typeIcon = Icons.event;
    }

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: AppStyles.mediumSpace),
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dateFormatter.format(date),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: typeColor,
                      ),
                    ),
                    Text(
                      timeFormatter.format(date),
                      style: TextStyle(
                        fontSize: 10,
                        color: typeColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppStyles.mediumSpace),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(typeIcon, size: 16, color: typeColor),
                        const SizedBox(width: 4),
                        Text(
                          type,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: typeColor,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: status == 'AGENDADO'
                                ? AppStyles.info.withOpacity(0.1)
                                : status == 'EXECUTADO'
                                    ? AppStyles.success.withOpacity(0.1)
                                    : AppStyles.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: status == 'AGENDADO'
                                  ? AppStyles.info
                                  : status == 'EXECUTADO'
                                      ? AppStyles.success
                                      : AppStyles.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppStyles.grey900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppStyles.grey600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
