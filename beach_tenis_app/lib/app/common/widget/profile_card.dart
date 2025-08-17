import 'package:flutter/material.dart';

import '../styles/app_styles.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final bool isActive;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? activeColor;
  final Color? inactiveColor;
  final List<String> features;

  const ProfileCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.isSelected = false,
    this.isActive = true,
    this.onTap,
    this.width,
    this.height,
    this.activeColor,
    this.inactiveColor,
    required this.features,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color cardColor = isActive ? (activeColor ?? AppStyles.primaryBlue) : (inactiveColor ?? AppStyles.grey400);

    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(AppStyles.radiusLarge),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isActive ? 0.15 : 0.05),
              blurRadius: isActive ? 8 : 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: iconColor,
            ),
            const SizedBox(height: AppStyles.smallSpace),
            Text(
              title,
              style: const TextStyle(
                color: AppStyles.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCardWide extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onTap;
  final String buttonText;

  const ProfileCardWide({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    this.onTap,
    this.buttonText = 'ASSINAR',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppStyles.largeSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppStyles.primaryBlue,
                  ),
                ),
                const Spacer(),
                Icon(
                  icon,
                  size: 32,
                  color: AppStyles.primaryBlue,
                ),
              ],
            ),
            const SizedBox(height: AppStyles.smallSpace),
            const Text(
              'FUNCIONALIDADES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppStyles.grey500,
              ),
            ),
            const SizedBox(height: AppStyles.smallSpace),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: AppStyles.grey700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppStyles.largeSpace),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: AppStyles.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
