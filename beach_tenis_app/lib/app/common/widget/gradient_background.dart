import 'package:flutter/material.dart';

import '../providers/theme_provider.dart';
import '../styles/app_styles.dart';
import 'package:provider/provider.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;

  const GradientBackground({
    Key? key,
    required this.child,
    this.colors,
    this.begin,
    this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Acessa o ThemeProvider para obter o tema atual
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    
    return Container(
      decoration: BoxDecoration(
        gradient: colors != null
            ? LinearGradient(
                begin: begin ?? Alignment.topCenter,
                end: end ?? Alignment.bottomCenter,
                colors: colors!,
              )
            : themeProvider.backgroundGradient,
      ),
      child: child,
    );
  }
}

class BeachTennisLogo extends StatelessWidget {
  final double? size;
  final Color? textColor;

  const BeachTennisLogo({
    Key? key,
    this.size = 120,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mascote do pato (placeholder com ícone)
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppStyles.primaryGreen,
            borderRadius: BorderRadius.circular(size! / 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            Icons.sports_tennis,
            size: size! * 0.6,
            color: AppStyles.white,
          ),
        ),
        const SizedBox(height: AppStyles.largeSpace),
        // Texto 40x40
        Text(
          'Apex Sports - Beach Tênis',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textColor ?? AppStyles.redAccent,
          ),
        ),
        const SizedBox(height: AppStyles.smallSpace),
        // Subtítulo
        Text(
          'ANÁLISE DE ALTO RENDIMENTO',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor ?? AppStyles.white,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
