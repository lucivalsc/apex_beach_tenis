import 'package:beach_tenis_app/app/layers/presenter/providers/auth_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/config_provider.dart';
import 'package:beach_tenis_app/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  static const String route = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isScreenLocked = false;
  bool _obscurePassword = true;
  late AuthProvider authProvider;
  late ConfigProvider configProvider;
  late Future<void> future;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> initScreen() async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    configProvider = Provider.of<ConfigProvider>(context, listen: false);

    await Future.delayed(const Duration(milliseconds: 200));

    _emailController.text = await configProvider.loadLastLoggedEmail();
    _passwordController.text = await configProvider.loadLastLoggedPassword();
  }

  @override
  void initState() {
    super.initState();
    future = initScreen();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;
    final isTinyScreen = size.height < 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF4A90E2).withOpacity(0.05),
              Colors.white,
              Colors.white,
              const Color(0xFF7ED321).withOpacity(0.03),
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: isTinyScreen
                              ? 16
                              : isSmallScreen
                                  ? 24
                                  : 32),

                      // Header com logo e texto SVG
                      _buildHeader(size, isSmallScreen, isTinyScreen),

                      SizedBox(
                          height: isTinyScreen
                              ? 20
                              : isSmallScreen
                                  ? 30
                                  : 40),

                      // Card do formulário
                      _buildLoginCard(context, isSmallScreen, isTinyScreen),

                      SizedBox(
                          height: isTinyScreen
                              ? 16
                              : isSmallScreen
                                  ? 24
                                  : 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Size size, bool isSmallScreen, bool isTinyScreen) {
    return Column(
      children: [
        // Logo SVG
        Container(
          width: isTinyScreen
              ? size.width * 0.18
              : isSmallScreen
                  ? size.width * 0.2
                  : size.width * 0.22,
          height: isTinyScreen
              ? size.width * 0.18
              : isSmallScreen
                  ? size.width * 0.2
                  : size.width * 0.22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4A90E2).withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 3,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: EdgeInsets.all(isTinyScreen
              ? 2
              : isSmallScreen
                  ? 3
                  : 4),
          child: SvgPicture.asset(
            'lib/app/common/assets/svg/logo.svg',
            fit: BoxFit.contain,
          ),
        ),

        SizedBox(
            height: isTinyScreen
                ? 16
                : isSmallScreen
                    ? 20
                    : 24),

        // Texto SVG
        SvgPicture.asset(
          'lib/app/common/assets/svg/texto.svg',
          width: isTinyScreen
              ? size.width * 0.5
              : isSmallScreen
                  ? size.width * 0.55
                  : size.width * 0.6,
          height: isTinyScreen
              ? 40
              : isSmallScreen
                  ? 50
                  : 60,
        ),
      ],
    );
  }

  Widget _buildLoginCard(BuildContext context, bool isSmallScreen, bool isTinyScreen) {
    return Flexible(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: const Color(0xFF4A90E2).withOpacity(0.06),
              blurRadius: 40,
              spreadRadius: 0,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        padding: EdgeInsets.all(isTinyScreen
            ? 20
            : isSmallScreen
                ? 24
                : 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Campo de email
            _buildInputField(
              controller: _emailController,
              label: 'Email',
              hint: 'Digite seu email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              isSmallScreen: isSmallScreen,
              isTinyScreen: isTinyScreen,
            ),

            SizedBox(height: isTinyScreen ? 16 : 20),

            // Campo de senha
            _buildPasswordField(isSmallScreen, isTinyScreen),

            SizedBox(height: isTinyScreen ? 8 : 12),

            // Link "Esqueci a senha"
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Implementar recuperação de senha
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF4A90E2),
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: isTinyScreen ? 4 : 6,
                  ),
                ),
                child: Text(
                  'Esqueci minha senha',
                  style: TextStyle(
                    fontSize: isTinyScreen ? 12 : 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4A90E2),
                  ),
                ),
              ),
            ),

            SizedBox(height: isTinyScreen ? 20 : 24),

            // Botão de login
            _buildLoginButton(isSmallScreen, isTinyScreen),

            SizedBox(height: isTinyScreen ? 20 : 24),

            // Divider
            _buildDivider(),

            SizedBox(height: isTinyScreen ? 16 : 20),

            // Link para cadastro
            _buildSignUpLink(context, isTinyScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    required bool isSmallScreen,
    required bool isTinyScreen,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTinyScreen ? 12 : 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
            letterSpacing: 0.1,
          ),
        ),
        SizedBox(height: isTinyScreen ? 6 : 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: isTinyScreen ? 14 : 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E293B),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: const Color(0xFF94A3B8),
                fontWeight: FontWeight.w400,
                fontSize: isTinyScreen ? 14 : 16,
              ),
              prefixIcon: Icon(
                icon,
                color: const Color(0xFF64748B),
                size: isTinyScreen ? 18 : 20,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: isTinyScreen ? 16 : 18,
                vertical: isTinyScreen ? 12 : 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(bool isSmallScreen, bool isTinyScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Senha',
          style: TextStyle(
            fontSize: isTinyScreen ? 12 : 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
            letterSpacing: 0.1,
          ),
        ),
        SizedBox(height: isTinyScreen ? 6 : 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: TextStyle(
              fontSize: isTinyScreen ? 14 : 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E293B),
            ),
            decoration: InputDecoration(
              hintText: 'Digite sua senha',
              hintStyle: TextStyle(
                color: const Color(0xFF94A3B8),
                fontWeight: FontWeight.w400,
                fontSize: isTinyScreen ? 14 : 16,
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: const Color(0xFF64748B),
                size: isTinyScreen ? 18 : 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: const Color(0xFF64748B),
                  size: isTinyScreen ? 18 : 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: isTinyScreen ? 16 : 18,
                vertical: isTinyScreen ? 12 : 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(bool isSmallScreen, bool isTinyScreen) {
    return Container(
      height: isTinyScreen
          ? 48
          : isSmallScreen
              ? 52
              : 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF4A90E2),
            Color(0xFF5BA3F5),
            Color(0xFF7ED321),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90E2).withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isScreenLocked ? null : _handleLogin,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: isTinyScreen ? 20 : 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isScreenLocked)
                  SizedBox(
                    width: isTinyScreen ? 16 : 18,
                    height: isTinyScreen ? 16 : 18,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                else
                  Icon(
                    Icons.login_rounded,
                    color: Colors.white,
                    size: isTinyScreen ? 18 : 20,
                  ),
                SizedBox(width: isTinyScreen ? 8 : 10),
                Text(
                  isScreenLocked ? 'Entrando...' : 'Entrar',
                  style: TextStyle(
                    fontSize: isTinyScreen ? 14 : 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFE2E8F0),
            height: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'ou',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF94A3B8),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFE2E8F0),
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpLink(BuildContext context, bool isTinyScreen) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('user-type-selection');
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF4A90E2),
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: isTinyScreen ? 8 : 10,
          ),
        ),
        child: RichText(
          text: TextSpan(
            text: 'Não tem uma conta? ',
            style: TextStyle(
              fontSize: isTinyScreen ? 13 : 15,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
            children: [
              TextSpan(
                text: 'Cadastre-se',
                style: TextStyle(
                  fontSize: isTinyScreen ? 13 : 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4A90E2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty) {
      showFlushbar(
        context,
        'Atenção!',
        'Email é um campo obrigatório',
        3,
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      showFlushbar(
        context,
        'Atenção!',
        'Senha é um campo obrigatório',
        3,
      );
      return;
    }

    setState(() => isScreenLocked = true);
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      await authProvider.signIn(
        context,
        mounted,
        _emailController.text,
        _passwordController.text,
      );
    } finally {
      if (mounted) {
        setState(() => isScreenLocked = false);
      }
    }
  }
}
