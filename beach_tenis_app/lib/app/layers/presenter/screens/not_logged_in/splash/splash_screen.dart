import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String route = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _textAnimationController;
  late AnimationController _backgroundAnimationController;
  late AnimationController _pulseAnimationController;
  late AnimationController _rotateAnimationController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _backgroundAnimationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _pulseAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _rotateAnimationController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    // Animações do logo
    _logoScaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    ));

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: const Interval(0.6, 1.0, curve: Curves.bounceOut),
    ));

    // Animações do texto
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeInOut,
    ));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.decelerate,
    ));

    // Animação de fundo
    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundAnimationController,
      curve: Curves.easeInOut,
    ));

    // Animação de pulso
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseAnimationController,
      curve: Curves.easeInOut,
    ));

    // Animação de rotação sutil
    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 0.02,
    ).animate(CurvedAnimation(
      parent: _rotateAnimationController,
      curve: Curves.easeInOut,
    ));

    _startAnimations();
  }

  void _startAnimations() async {
    // Inicia animação de fundo
    _backgroundAnimationController.forward();

    // Aguarda um pouco e inicia logo
    await Future.delayed(const Duration(milliseconds: 300));
    _logoAnimationController.forward();

    // Inicia animações contínuas
    _pulseAnimationController.repeat(reverse: true);
    _rotateAnimationController.repeat(reverse: true);

    // Aguarda logo aparecer e inicia texto
    await Future.delayed(const Duration(milliseconds: 800));
    _textAnimationController.forward();

    // Navega para próxima tela após animações
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      // Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _textAnimationController.dispose();
    _backgroundAnimationController.dispose();
    _pulseAnimationController.dispose();
    _rotateAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimationController,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF4A90E2).withOpacity(0.9 + _backgroundAnimation.value * 0.1),
                  const Color(0xFF5BA3F5).withOpacity(0.8 + _backgroundAnimation.value * 0.2),
                  const Color(0xFF7ED321).withOpacity(0.7 + _backgroundAnimation.value * 0.3),
                ],
                stops: [
                  0.0 + _backgroundAnimation.value * 0.1,
                  0.5 + _backgroundAnimation.value * 0.2,
                  1.0,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Elementos decorativos de fundo
                _buildBackgroundElements(),

                // Conteúdo principal
                SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),

                        // Logo SVG animado
                        _buildAnimatedLogo(size),

                        const SizedBox(height: 60),

                        // Texto SVG animado
                        _buildAnimatedText(),

                        const Spacer(),

                        // Loading indicator moderno
                        _buildModernLoader(),

                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return AnimatedBuilder(
      animation: _backgroundAnimationController,
      builder: (context, child) {
        return Stack(
          children: [
            // Círculos decorativos flutuantes
            Positioned(
              top: 100 + (_backgroundAnimation.value * 20),
              right: 50,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              top: 200 + (_backgroundAnimation.value * -15),
              left: 30,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            Positioned(
              bottom: 150 + (_backgroundAnimation.value * 25),
              right: 80,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedLogo(Size size) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _logoAnimationController,
        _pulseAnimationController,
        _rotateAnimationController,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScaleAnimation.value * _pulseAnimation.value,
          child: Transform.rotate(
            angle: _rotateAnimation.value,
            child: Opacity(
              opacity: _logoOpacityAnimation.value,
              child: Container(
                width: size.width * 0.35,
                height: size.width * 0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                    BoxShadow(
                      color: const Color(0xFF4A90E2).withOpacity(0.4),
                      blurRadius: 50,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0.9),
                        ],
                      ),
                    ),
                    child: SvgPicture.asset(
                      'lib/app/common/assets/svg/logo.svg',
                      width: size.width * 0.25,
                      height: size.width * 0.25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedText() {
    return SlideTransition(
      position: _textSlideAnimation,
      child: FadeTransition(
        opacity: _textFadeAnimation,
        child: Column(
          children: [
            // Texto SVG principal
            SvgPicture.asset(
              'lib/app/common/assets/svg/texto.svg',
              width: 250,
              height: 80,
            ),
            const SizedBox(height: 16),

            // Tagline adicional
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Conectando sonhos, criando famílias',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.95),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.8,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernLoader() {
    return FadeTransition(
      opacity: _textFadeAnimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Loader customizado com gradiente
          AnimatedBuilder(
            animation: _pulseAnimationController,
            builder: (context, child) {
              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.6),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(0xFF4A90E2).withOpacity(0.8),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // Texto de carregamento
          AnimatedBuilder(
            animation: _pulseAnimationController,
            builder: (context, child) {
              return Opacity(
                opacity: 0.6 + (_pulseAnimation.value - 1.0) * 0.4,
                child: Text(
                  'Preparando sua experiência...',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
