import 'package:flutter/material.dart';
import '../../../../../../common/styles/app_styles.dart';

class ProfessorListItem extends StatelessWidget {
  final String name;
  final String? photoUrl;
  final String specialty;
  final int studentCount;
  final VoidCallback? onTap;

  const ProfessorListItem({
    Key? key,
    required this.name,
    this.photoUrl,
    required this.specialty,
    required this.studentCount,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              CircleAvatar(
                radius: 25,
                backgroundColor: AppStyles.primaryBlue.withOpacity(0.1),
                backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
                child: photoUrl == null
                    ? Text(
                        name.isNotEmpty ? name[0].toUpperCase() : '?',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppStyles.primaryBlue,
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
                    Text(
                      specialty,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppStyles.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppStyles.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.people,
                          size: 12,
                          color: AppStyles.primaryBlue,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          studentCount.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppStyles.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Icon(
                    Icons.chevron_right,
                    color: AppStyles.grey400,
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
