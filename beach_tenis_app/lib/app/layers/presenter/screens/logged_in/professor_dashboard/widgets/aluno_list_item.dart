import 'package:flutter/material.dart';

import '../../../../../../common/styles/app_styles.dart';

class AlunoListItem extends StatelessWidget {
  final String name;
  final String? photoUrl;
  final String level;
  final int progress;
  final String since;
  final VoidCallback onTap;

  const AlunoListItem({
    Key? key,
    required this.name,
    this.photoUrl,
    required this.level,
    required this.progress,
    required this.since,
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
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppStyles.lightBlue,
                backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
                child: photoUrl == null
                    ? Text(
                        name.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppStyles.white,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: AppStyles.mediumSpace),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppStyles.grey900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getLevelColor(),
                            borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                          ),
                          child: Text(
                            level,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppStyles.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          since,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppStyles.grey600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                            child: LinearProgressIndicator(
                              value: progress / 100,
                              backgroundColor: AppStyles.grey200,
                              color: _getProgressColor(),
                              minHeight: 8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$progress%',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppStyles.grey700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppStyles.grey600,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLevelColor() {
    switch (level) {
      case 'Iniciante':
        return AppStyles.primaryGreen;
      case 'Intermediário':
        return AppStyles.warning;
      case 'Avançado':
        return AppStyles.primaryBlue;
      default:
        return AppStyles.grey600;
    }
  }

  Color _getProgressColor() {
    if (progress < 40) {
      return AppStyles.primaryGreen;
    } else if (progress < 70) {
      return AppStyles.warning;
    } else {
      return AppStyles.primaryBlue;
    }
  }
}
