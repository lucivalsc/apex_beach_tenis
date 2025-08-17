import 'dart:math' as math;

import 'package:beach_tenis_app/app/layers/presenter/screens/not_logged_in/auth/auth_screen.dart';
import 'package:beach_tenis_app/navigation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String route = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _ballController;
  late AnimationController _logoController;
  late AnimationController _fadeController;

  late Animation<double> _waveAnimation;
  late Animation<double> _ballAnimation;
  late Animation<double> _logoAnimation;
  late Animation<double> _fadeAnimation;

  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();

    // Controlador para as ondas (movimento contínuo)
    _waveController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Controlador para as bolas (movimento mais lento)
    _ballController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    // Controlador para animação do logo (entrada)
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Controlador para fade in geral
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _waveAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _waveController,
      curve: Curves.linear,
    ));

    _ballAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _ballController,
      curve: Curves.linear,
    ));

    _logoAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // Iniciar animações
    _fadeController.forward();
    _logoController.forward();

    // Navegar para tela de auth após 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        push(context, const AuthScreen());
      }
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    _ballController.dispose();
    _logoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _isDarkMode
                ? [
                    const Color(0xFF2C3E50),
                    const Color(0xFF1A252F),
                  ]
                : [
                    const Color(0xFF87CEEB), // Azul claro no topo
                    const Color(0xFF4A90E2), // Azul primário na base
                  ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Stack(
              children: [
                // Animação de ondas suaves no fundo
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _waveAnimation,
                    builder: (context, child) {
                      return CustomPaint(
                        size: Size.infinite,
                        painter: BackgroundWavePainter(
                          animation: _waveAnimation.value,
                          isDarkMode: _isDarkMode,
                        ),
                      );
                    },
                  ),
                ),

                // Bolas flutuantes animadas
                ...List.generate(
                  6,
                  (index) => AnimatedBuilder(
                    animation: _ballAnimation,
                    builder: (context, child) {
                      final screenWidth = MediaQuery.of(context).size.width;
                      final screenHeight = MediaQuery.of(context).size.height;

                      final ballX =
                          (screenWidth * 0.1) + (screenWidth * 0.8 * ((index + _ballAnimation.value) % 6) / 6);
                      final ballY =
                          (screenHeight * 0.2) + (screenHeight * 0.6 * math.sin(_ballAnimation.value + index)) * 0.3;

                      return Positioned(
                        left: ballX,
                        top: ballY,
                        child: Container(
                          width: 12 + (index % 3) * 4,
                          height: 12 + (index % 3) * 4,
                          decoration: BoxDecoration(
                            color: [
                              Colors.white.withOpacity(0.3),
                              const Color(0xFF4CAF50).withOpacity(0.4),
                              const Color(0xFFFF0000).withOpacity(0.3),
                            ][index % 3],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Conteúdo principal
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Status bar area (simulado)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '08:00',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.grey[300] : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.wifi, color: _isDarkMode ? Colors.grey[300] : Colors.white, size: 18),
                              const SizedBox(width: 4),
                              Icon(Icons.signal_cellular_4_bar,
                                  color: _isDarkMode ? Colors.grey[300] : Colors.white, size: 18),
                              const SizedBox(width: 4),
                              Icon(Icons.battery_full, color: _isDarkMode ? Colors.grey[300] : Colors.white, size: 18),
                            ],
                          ),
                        ],
                      ),

                      // Conteúdo central
                      Expanded(
                        child: Center(
                          child: ScaleTransition(
                            scale: _logoAnimation,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Logo central com mascote animado
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Círculo de fundo pulsante
                                    AnimatedBuilder(
                                      animation: _waveAnimation,
                                      builder: (context, child) {
                                        return Container(
                                          width: 140 + math.sin(_waveAnimation.value * 2) * 10,
                                          height: 140 + math.sin(_waveAnimation.value * 2) * 10,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF4CAF50).withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(80),
                                          ),
                                        );
                                      },
                                    ),
                                    // Logo principal
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4CAF50),
                                        borderRadius: BorderRadius.circular(60),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            blurRadius: 15,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.sports_tennis,
                                        size: 72,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                // Texto principal com animação
                                Text(
                                  'Apex Sports - Beach Tênis',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: _isDarkMode ? const Color(0xFFFF6B6B) : const Color(0xFFFF0000),
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.3),
                                        offset: const Offset(0, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                // Subtítulo
                                Text(
                                  'ANÁLISE DE ALTO RENDIMENTO',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _isDarkMode ? Colors.grey[300] : Colors.white,
                                    letterSpacing: 1.2,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: const Offset(0, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 40),
                                // Indicador de carregamento
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _isDarkMode ? Colors.grey[300]! : Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Toggle modo escuro na parte inferior
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Switch(
                            value: _isDarkMode,
                            onChanged: (value) {
                              setState(() {
                                _isDarkMode = value;
                              });
                            },
                            activeColor: const Color(0xFF4CAF50),
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.white.withOpacity(0.3),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Modo escuro',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.grey[300] : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Classe para desenhar ondas suaves de fundo
class BackgroundWavePainter extends CustomPainter {
  final double animation;
  final bool isDarkMode;

  BackgroundWavePainter({
    required this.animation,
    required this.isDarkMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Primeira camada de ondas (mais baixa e transparente)
    _drawWave(canvas, size, animation, size.height * 0.7, 40.0,
        isDarkMode ? Colors.white.withOpacity(0.03) : Colors.white.withOpacity(0.05));

    // Segunda camada de ondas (meio)
    _drawWave(canvas, size, animation + 1.0, size.height * 0.8, 30.0,
        isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.08));

    // Terceira camada de ondas (mais alta)
    _drawWave(canvas, size, animation + 2.0, size.height * 0.9, 20.0,
        isDarkMode ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.12));
  }

  void _drawWave(Canvas canvas, Size size, double phase, double baseY, double amplitude, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveLength = size.width / 1.5;

    path.moveTo(0, size.height);
    path.lineTo(0, baseY);

    for (double x = 0; x <= size.width; x += 2) {
      final y = baseY + amplitude * math.sin((x / waveLength * 2 * math.pi) + phase);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BackgroundWavePainter oldDelegate) {
    return oldDelegate.animation != animation || oldDelegate.isDarkMode != isDarkMode;
  }
}

// Classe para desenhar as ondas animadas (mantida para compatibilidade)
class WavePainter extends CustomPainter {
  final double animation;
  final Color color;
  final double waveHeight;

  WavePainter({
    required this.animation,
    required this.color,
    required this.waveHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveLength = size.width / 2;

    path.moveTo(0, size.height);

    for (double x = 0; x <= size.width; x++) {
      final y = size.height - waveHeight * math.sin((x / waveLength * 2 * math.pi) + animation);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
