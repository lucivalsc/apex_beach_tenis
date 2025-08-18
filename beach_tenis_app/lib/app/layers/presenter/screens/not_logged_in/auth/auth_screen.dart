/// Widget para a linha de checkbox.import 'package:apex_sports/app/common/providers/theme_provider.dart';
import 'package:apex_sports/app/common/providers/theme_provider.dart';
import 'package:apex_sports/app/layers/presenter/providers/auth_provider.dart';
import 'package:apex_sports/app/layers/presenter/screens/logged_in/arena_dashboard/arena_dashboard_screen.dart';
import 'package:apex_sports/navigation.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const String route = "auth";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late AuthProvider authProvider;

  // Controllers para os campos de texto
  final _loginEmailController = TextEditingController(text: 'arena@exemplo.com');
  final _loginPasswordController = TextEditingController(text: '912167');
  final _registerNameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPhoneController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerConfirmPasswordController = TextEditingController();

  // Variáveis de estado da UI
  bool _keepLoggedIn = false;
  bool _acceptTerms = false;
  bool _acceptCommunications = false;

  // Separação da visibilidade da senha para cada campo
  bool _obscureLoginPassword = true;
  bool _obscureRegisterPassword = true;
  bool _obscureConfirmPassword = true;

  // Dropdown para tipo de acesso
  String? _selectedAccessType;
  final List<Map<String, String>> _accessTypes = [
    {'id': 'ARENA', 'label': 'Arena'},
    {'id': 'ATLETA', 'label': 'Atleta'},
    {'id': 'ALUNO', 'label': 'Aluno'},
    {'id': 'PROFESSOR', 'label': 'Professor'},
    {'id': 'PROFISSIONAL_TECNICO', 'label': 'Profissional Técnico'},
    {'id': 'ADMIN', 'label': 'Administrador'},
  ];

  // Controle de validação do formulário
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Adicionar listeners para os campos do registro
    _registerNameController.addListener(_validateForm);
    _registerEmailController.addListener(_validateForm);
    _registerPhoneController.addListener(_validateForm);
    _registerPasswordController.addListener(_validateForm);
    _registerConfirmPasswordController.addListener(_validateForm);
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
    authProvider.signIn(
      context,
      mounted,
      _loginEmailController.text,
      _loginPasswordController.text,
    );
  }

  void _handleRegister() {
    // TODO: Implementar lógica de registro
    print("Register attempt for: ${_registerEmailController.text}");
    print("Access type: $_selectedAccessType");
    push(context, const ArenaDashboardScreen());
  }

  void _handleFacebookLogin() {
    // TODO: Implementar login com Facebook
  }

  void _handleGoogleLogin() {
    // TODO: Implementar login com Google
  }

  /// Valida todos os campos do formulário de registro
  void _validateForm() {
    final isNameValid = _isValidName(_registerNameController.text);
    final isEmailValid = _isValidEmail(_registerEmailController.text);
    final isPhoneValid = _isValidPhone(_registerPhoneController.text);
    final isPasswordValid = _isValidPassword(_registerPasswordController.text);
    final isConfirmPasswordValid = _registerPasswordController.text == _registerConfirmPasswordController.text;
    final isAccessTypeSelected = _selectedAccessType != null;
    final areTermsAccepted = _acceptTerms;

    final newIsFormValid = isNameValid &&
        isEmailValid &&
        isPhoneValid &&
        isPasswordValid &&
        isConfirmPasswordValid &&
        isAccessTypeSelected &&
        areTermsAccepted;

    if (_isFormValid != newIsFormValid) {
      setState(() {
        _isFormValid = newIsFormValid;
      });
    }
  }

  /// Valida se o nome tem mais de uma palavra
  bool _isValidName(String name) {
    if (name.trim().isEmpty) return false;
    return name.trim().split(' ').where((word) => word.isNotEmpty).length > 1;
  }

  /// Valida formato de email
  bool _isValidEmail(String email) {
    if (email.trim().isEmpty) return false;
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email.trim());
  }

  /// Valida telefone brasileiro (formato com máscara)
  bool _isValidPhone(String phone) {
    if (phone.trim().isEmpty) return false;
    // Remove formatação para validar
    String cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    // Telefone brasileiro: 11 dígitos (celular) ou 10 dígitos (fixo)
    return cleanPhone.length == 10 || cleanPhone.length == 11;
  }

  /// Valida se a senha tem no mínimo 9 caracteres
  bool _isValidPassword(String password) {
    return password.length >= 9;
  }

  @override
  Widget build(BuildContext context) {
    // Acessa o ThemeProvider para obter o tema atual
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      // resizeToAvoidBottomInset: true (padrão) já ajuda, mas o SingleChildScrollView é essencial
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.backgroundGradient,
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
        // Cor de fundo do card
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            // Cor de fundo do tabbar
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
                color: const Color(0xFF4A90E2),
                borderRadius: BorderRadius.circular(30),
              ),
              // Importante: ajustar o container pai do TabBar
              padding: const EdgeInsets.all(6),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              tabs: [
                Tab(
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: const Text('Entrar'),
                  ),
                ),
                Tab(
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: const Text('Registrar'),
                  ),
                ),
              ],
            ),
          ),
          // Usamos um SizedBox para dar uma altura máxima ao TabBarView,
          // mas ele se ajustará ao conteúdo.
          SizedBox(
            // Altura aumentada para acomodar o novo campo
            height: 500,
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
          const SizedBox(height: 6),
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
          const SizedBox(height: 6),
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
          const SizedBox(height: 6),
          _buildAuthButton(text: 'ENTRAR', onPressed: _handleLogin),
          const SizedBox(height: 6),
          _buildSocialButton(
            text: 'Login com Facebook',
            icon: Icons.facebook,
            onPressed: _handleFacebookLogin,
            backgroundColor: const Color(0xFF1877F2),
            foregroundColor: Colors.white,
          ),
          const SizedBox(height: 6),
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
          const SizedBox(height: 6),
          _buildAccessTypeDropdown(),
          const SizedBox(height: 6),
          _buildTextField(
              controller: _registerEmailController,
              labelText: 'E-mail',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _registerPhoneController,
            labelText: 'Telefone',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            inputFormatters: [TelefoneInputFormatter()],
          ),
          const SizedBox(height: 6),
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
          const SizedBox(height: 6),
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
          const SizedBox(height: 6),
          _buildCheckboxRow(
            label: 'Aceito os Termos de Uso',
            value: _acceptTerms,
            onChanged: (value) {
              setState(() => _acceptTerms = value ?? false);
              _validateForm(); // Revalidar quando mudar os termos
            },
            isLink: true,
          ),
          _buildCheckboxRow(
            label: 'Aceito receber comunicações',
            value: _acceptCommunications,
            onChanged: (value) => setState(() => _acceptCommunications = value ?? false),
          ),
          const SizedBox(height: 6),
          // Feedback visual da validação
          _buildValidationFeedback(),
          const SizedBox(height: 6),
          _buildAuthButton(
            text: 'REGISTRAR',
            onPressed: _isFormValid ? _handleRegister : null,
          ),
        ],
      ),
    );
  }

  /// Widget para o dropdown de tipo de acesso.
  Widget _buildAccessTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedAccessType,
      decoration: InputDecoration(
        labelText: 'Tipo de Acesso',
        prefixIcon: const Icon(Icons.security, color: Color(0xFF4A90E2)),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      hint: const Text('Selecione o tipo de acesso'),
      items: _accessTypes.map((accessType) {
        return DropdownMenuItem<String>(
          value: accessType['id'],
          child: Text(accessType['label']!),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedAccessType = newValue;
        });
        _validateForm(); // Revalidar quando mudar o tipo de acesso
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecione um tipo de acesso';
        }
        return null;
      },
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
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
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

  /// Widget para mostrar feedback de validação
  Widget _buildValidationFeedback() {
    if (_isFormValid) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade600, size: 16),
            const SizedBox(width: 8),
            Text(
              'Todos os campos estão válidos',
              style: TextStyle(color: Colors.green.shade700, fontSize: 12),
            ),
          ],
        ),
      );
    }

    // Lista de validações que falharam
    List<String> errors = [];

    if (!_isValidName(_registerNameController.text)) {
      errors.add('Nome deve conter nome e sobrenome');
    }
    if (_selectedAccessType == null) {
      errors.add('Selecione um tipo de acesso');
    }
    if (!_isValidEmail(_registerEmailController.text)) {
      errors.add('Email inválido');
    }
    if (!_isValidPhone(_registerPhoneController.text)) {
      errors.add('Telefone inválido');
    }
    if (!_isValidPassword(_registerPasswordController.text)) {
      errors.add('Senha deve ter no mínimo 9 caracteres');
    }
    if (_registerPasswordController.text != _registerConfirmPasswordController.text) {
      errors.add('Senhas não coincidem');
    }
    if (!_acceptTerms) {
      errors.add('Aceite os termos de uso');
    }

    if (errors.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange.shade600, size: 16),
              const SizedBox(width: 8),
              Text(
                'Complete os seguintes campos:',
                style: TextStyle(color: Colors.orange.shade700, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ...errors.take(3).map((error) => Padding(
                padding: const EdgeInsets.only(left: 24, top: 2),
                child: Text(
                  '• $error',
                  style: TextStyle(color: Colors.orange.shade600, fontSize: 11),
                ),
              )),
          if (errors.length > 3)
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 2),
              child: Text(
                '• e mais ${errors.length - 3} validação${errors.length - 3 > 1 ? 'ões' : ''}...',
                style: TextStyle(color: Colors.orange.shade600, fontSize: 11),
              ),
            ),
        ],
      ),
    );
  }

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Switch(
          value: isDarkMode,
          onChanged: (value) {
            // Alterna o tema usando o ThemeProvider
            themeProvider.toggleTheme();
          },
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
