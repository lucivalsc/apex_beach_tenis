import 'package:flutter/material.dart';

/// Widget que adiciona automaticamente padding na parte inferior para evitar
/// que elementos fiquem atrás dos botões de navegação do sistema Android.
class SafeBottomPadding extends StatelessWidget {
  final Widget child;
  
  /// Padding adicional opcional além do espaço dos botões de navegação
  final double additionalBottomPadding;

  const SafeBottomPadding({
    Key? key,
    required this.child,
    this.additionalBottomPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtém o padding inferior necessário para evitar os botões de navegação
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPadding + additionalBottomPadding,
      ),
      child: child,
    );
  }
}
