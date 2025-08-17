import 'package:flutter/material.dart';

import '../../../../../../common/styles/app_styles.dart';

class AtletaCard extends StatelessWidget {
  final String name;
  final String? photoUrl;
  final String type;
  final String historico;
  final String ultimoAtendimento;
  final VoidCallback onTap;

  const AtletaCard({
    Key? key,
    required this.name,
    this.photoUrl,
    required this.type,
    required this.historico,
    required this.ultimoAtendimento,
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
                backgroundColor: AppStyles.primaryBlue,
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
                            color: _getTypeColor(),
                            borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                          ),
                          child: Text(
                            type,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppStyles.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          ultimoAtendimento,
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
                        const Icon(Icons.notes, size: 14, color: AppStyles.grey600),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            historico,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppStyles.grey700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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

  Color _getTypeColor() {
    switch (type) {
      case 'Atleta Profissional':
        return AppStyles.primaryBlue;
      case 'Atleta Amador':
        return AppStyles.primaryGreen;
      default:
        return AppStyles.grey600;
    }
  }
}
