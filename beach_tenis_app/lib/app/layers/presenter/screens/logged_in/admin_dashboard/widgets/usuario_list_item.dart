import 'package:flutter/material.dart';

import '../../../../../../common/styles/app_styles.dart';

class UsuarioListItem extends StatelessWidget {
  final String name;
  final String? photoUrl;
  final String type;
  final String email;
  final String cadastro;
  final String status;
  final VoidCallback onTap;

  const UsuarioListItem({
    Key? key,
    required this.name,
    this.photoUrl,
    required this.type,
    required this.email,
    required this.cadastro,
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
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: _getTypeColor(),
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(),
                            borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                          ),
                          child: Text(
                            status,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppStyles.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.email, size: 14, color: AppStyles.grey600),
                        const SizedBox(width: 4),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppStyles.grey700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: AppStyles.grey600),
                        const SizedBox(width: 4),
                        Text(
                          cadastro,
                          style: const TextStyle(
                            fontSize: 12,
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

  Color _getTypeColor() {
    switch (type) {
      case 'ADMIN':
        return AppStyles.grey800;
      case 'ARENA':
        return AppStyles.primaryBlue;
      case 'PROFESSOR':
        return AppStyles.primaryBlue;
      case 'ATLETA':
        return AppStyles.primaryGreen;
      case 'ALUNO':
        return AppStyles.primaryGreen;
      case 'PROFISSIONAL_TECNICO':
        return AppStyles.warning;
      default:
        return AppStyles.grey600;
    }
  }

  Color _getStatusColor() {
    switch (status) {
      case 'ATIVO':
        return AppStyles.success;
      case 'PENDENTE':
        return AppStyles.warning;
      case 'INATIVO':
        return AppStyles.error;
      default:
        return AppStyles.grey600;
    }
  }
}
