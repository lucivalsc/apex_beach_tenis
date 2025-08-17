import 'package:beach_tenis_app/app/layers/presenter/screens/logged_in/arena_dashboard/arena_dashboard_screen.dart';
import 'package:beach_tenis_app/navigation.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const String route = "auth";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Controllers para os campos de texto
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _registerNameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPhoneController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerConfirmPasswordController = TextEditingController();

  // Variáveis de estado da UI
  bool _isDarkMode = false;
  bool _keepLoggedIn = false;
  final bool _isWhatsApp = false;
  bool _acceptTerms = false;
  bool _acceptCommunications = false;

  // Separação da visibilidade da senha para cada campo
  bool _obscureLoginPassword = true;
  bool _obscureRegisterPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerNameController.dispose();
    _registerEmailController.dispose();
    _registerPhoneController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();
    super.dispose();
  }

  // --- Lógica de Negócio ---
  void _handleLogin() {
    // TODO: Implementar lógica de login
    print("Login attempt with: ${_loginEmailController.text}");
    push(context, const ArenaDashboardScreen());
  }

  void _handleRegister() {
    // TODO: Implementar lógica de registro
    print("Register attempt for: ${_registerEmailController.text}");
    push(context, const ArenaDashboardScreen());
  }

  void _handleFacebookLogin() {
    // TODO: Implementar login com Facebook
  }

  void _handleGoogleLogin() {
    // TODO: Implementar login com Google
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true (padrão) já ajuda, mas o SingleChildScrollView é essencial
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF87CEEB), // Azul claro no topo
              Color(0xFF4A90E2), // Azul primário na base
            ],
          ),
        ),
        // SingleChildScrollView permite que a tela inteira role quando o teclado aparece
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Espaçamento superior para centralizar o conteúdo em telas maiores
                  const SizedBox(height: 40),
                  _buildHeader(),
                  const SizedBox(height: 30),
                  _buildAuthCard(),
                  const SizedBox(height: 20),
                  _buildDarkModeToggle(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Constrói o cabeçalho com o logo e o título.
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(Icons.sports_tennis, size: 48, color: Colors.white),
        ),
        const SizedBox(height: 12),
        const Text(
          'Apex Sports - Beach Tênis',
          style: TextStyle(
              fontSize: 22, // Levemente reduzido para economizar espaço
              fontWeight: FontWeight.bold,
              color: Colors.white, // Cor ajustada para melhor contraste
              shadows: [Shadow(blurRadius: 2.0, color: Colors.black26, offset: Offset(1, 1))]),
        ),
        const SizedBox(height: 4),
        const Text(
          'ANÁLISE DE ALTO RENDIMENTO',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  /// Constrói o card principal com as abas de Login e Registro.
  Widget _buildAuthCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: const Color(0xFF4A90E2),
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              tabs: const [
                Tab(text: 'Entrar'),
                Tab(text: 'Registrar'),
              ],
            ),
          ),
          // Usamos um SizedBox para dar uma altura máxima ao TabBarView,
          // mas ele se ajustará ao conteúdo.
          SizedBox(
            // Altura pode ser ajustada conforme necessidade.
            // O conteúdo interno ainda será rolável se exceder.
            height: 450,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLoginTab(),
                _buildRegisterTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Constrói a aba de Login.
  Widget _buildLoginTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
            controller: _loginEmailController,
            labelText: 'Usuário ou e-mail',
            prefixIcon: Icons.person,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _loginPasswordController,
            labelText: 'Senha',
            prefixIcon: Icons.lock,
            obscureText: _obscureLoginPassword,
            suffixIcon: IconButton(
              icon: Icon(_obscureLoginPassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey[500]),
              onPressed: () => setState(() => _obscureLoginPassword = !_obscureLoginPassword),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _keepLoggedIn,
                onChanged: (value) => setState(() => _keepLoggedIn = value ?? false),
                activeColor: const Color(0xFF4A90E2),
              ),
              const Text('Manter conectado'),
              const Spacer(),
              TextButton(
                onPressed: () {/* TODO: Implementar esqueci a senha */},
                child: const Text('Esqueci a senha', style: TextStyle(color: Color(0xFF4A90E2))),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildAuthButton(text: 'ENTRAR', onPressed: _handleLogin),
          const SizedBox(height: 24),
          _buildSocialButton(
            text: 'Login com Facebook',
            icon: Icons.facebook,
            onPressed: _handleFacebookLogin,
            backgroundColor: const Color(0xFF1877F2),
            foregroundColor: Colors.white,
          ),
          const SizedBox(height: 12),
          _buildSocialButton(
            text: 'Login com Google',
            icon: Icons.g_mobiledata, // Ícone de exemplo
            onPressed: _handleGoogleLogin,
            isOutlined: true,
          ),
        ],
      ),
    );
  }

  /// Constrói a aba de Registro.
  Widget _buildRegisterTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
              controller: _registerNameController, labelText: 'Nome Completo', prefixIcon: Icons.person_outline),
          const SizedBox(height: 16),
          _buildTextField(
              controller: _registerEmailController,
              labelText: 'E-mail',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 16),
          _buildTextField(
              controller: _registerPhoneController,
              labelText: 'Telefone',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _registerPasswordController,
            labelText: 'Senha',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscureRegisterPassword,
            suffixIcon: IconButton(
              icon: Icon(_obscureRegisterPassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey[500]),
              onPressed: () => setState(() => _obscureRegisterPassword = !_obscureRegisterPassword),
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _registerConfirmPasswordController,
            labelText: 'Confirmar Senha',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscureConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey[500]),
              onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),
          ),
          const SizedBox(height: 16),
          _buildCheckboxRow(
            label: 'Aceito os Termos de Uso',
            value: _acceptTerms,
            onChanged: (value) => setState(() => _acceptTerms = value ?? false),
            isLink: true,
          ),
          _buildCheckboxRow(
            label: 'Aceito receber comunicações',
            value: _acceptCommunications,
            onChanged: (value) => setState(() => _acceptCommunications = value ?? false),
          ),
          const SizedBox(height: 24),
          _buildAuthButton(
            text: 'REGISTRAR',
            onPressed: _acceptTerms ? _handleRegister : null, // Habilita/desabilita o botão
          ),
        ],
      ),
    );
  }

  /// Widget genérico para campos de texto.
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: const Color(0xFF4A90E2)),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// Widget genérico para os botões principais de autenticação.
  Widget _buildAuthButton({required String text, VoidCallback? onPressed}) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A90E2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          disabledBackgroundColor: Colors.grey.shade300,
        ),
        child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  /// Widget genérico para os botões de login social.
  Widget _buildSocialButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    bool isOutlined = false,
  }) {
    return SizedBox(
      height: 45,
      child: isOutlined
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, color: Colors.grey[700]),
              label: Text(text, style: TextStyle(color: Colors.grey[700])),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, color: foregroundColor),
              label: Text(text, style: TextStyle(color: foregroundColor)),
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
    );
  }

  /// Widget para a linha de checkbox.
  Widget _buildCheckboxRow({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
    bool isLink = false,
  }) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged, activeColor: const Color(0xFF4A90E2)),
        Expanded(
          child: isLink
              ? GestureDetector(
                  onTap: () {/* TODO: Abrir termos de uso */},
                  child: Text(
                    label,
                    style: const TextStyle(color: Color(0xFF4A90E2), decoration: TextDecoration.underline),
                  ),
                )
              : Text(label),
        ),
      ],
    );
  }

  /// Constrói o seletor de modo escuro.
  Widget _buildDarkModeToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Switch(
          value: _isDarkMode,
          onChanged: (value) => setState(() => _isDarkMode = value),
          activeColor: Colors.white,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.white.withOpacity(0.3),
        ),
        const SizedBox(width: 12),
        const Text(
          'Modo escuro',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
