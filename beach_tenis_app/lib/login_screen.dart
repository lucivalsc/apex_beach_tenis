import 'package:beach_tenis_app/profile_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  // Form controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State variables
  bool _isDarkMode = false;
  bool _rememberMe = false;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // Tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Toggle dark mode
  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  // Handle login
  void _handleLogin() {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorDialog('Por favor, preencha todos os campos');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      // Show success and navigate to home
      // _showSuccessDialog();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileSelectionScreen()),
      );
    });
  }

  // Facebook login
  void _handleFacebookLogin() {
    _showInfoDialog('Login com Facebook');
  }

  // Google login
  void _handleGoogleLogin() {
    _showInfoDialog('Login com Google');
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show info dialog
  void _showInfoDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Informação'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show success dialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sucesso'),
        content: const Text('Login realizado com sucesso!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show forgot password dialog
  void _showForgotPasswordDialog() {
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recuperar Senha'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Digite seu e-mail para recuperar sua senha:'),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (emailController.text.isEmpty) {
                _showErrorDialog('Por favor, digite seu e-mail');
              } else {
                Navigator.of(context).pop();
                _showInfoDialog('Instruções enviadas para: ${emailController.text}');
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode
          ? ThemeData.dark().copyWith(primaryColor: Colors.blue)
          : ThemeData.light().copyWith(primaryColor: Colors.blue),
      child: Scaffold(
        backgroundColor: const Color(0xFF65B6FB),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),

                // Logo and title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.string(
                        _duckSvgString,
                        width: 120,
                        height: 120,
                      ),
                    ],
                  ),
                ),

                // 40x40 display
                const FortyByFortyDisplay(),

                // Analysis text
                const Text(
                  "ANÁLISE DE ALTO RENDIMENTO",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Login container
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: _isDarkMode ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(30),
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
                      // Tab bar
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.blue,
                        unselectedLabelColor: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        indicatorColor: Colors.blue,
                        tabs: const [
                          Tab(
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.login, size: 18),
                                SizedBox(width: 8),
                                Text("Entrar"),
                              ],
                            ),
                          ),
                          Tab(
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_add, size: 18),
                                SizedBox(width: 8),
                                Text("Registrar"),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Tab view
                      SizedBox(
                        height: 480, // Fixed height for the tab view
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Login tab
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: _buildLoginTab(),
                            ),

                            // Register tab
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: _buildRegisterTab(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Dark mode toggle
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Switch(
                      value: _isDarkMode,
                      onChanged: _toggleDarkMode,
                      activeColor: Colors.white,
                      activeTrackColor: Colors.blueGrey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Modo escuro",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: _isDarkMode ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build the login tab
  Widget _buildLoginTab() {
    return Column(
      children: [
        // User avatar
        CircleAvatar(
          radius: 40,
          backgroundColor: _isDarkMode ? Colors.grey[700] : Colors.grey[300],
          child: Icon(
            Icons.person,
            size: 50,
            color: _isDarkMode ? Colors.grey[400] : Colors.grey[500],
          ),
        ),
        const SizedBox(height: 20),

        // Username field
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            filled: true,
            fillColor: _isDarkMode ? Colors.grey[700] : Colors.grey[200],
            hintText: "Usuário ou e-mail",
            hintStyle: TextStyle(color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            prefixIcon: Icon(Icons.person, color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        const SizedBox(height: 15),

        // Password field
        TextField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            filled: true,
            fillColor: _isDarkMode ? Colors.grey[700] : Colors.grey[200],
            hintText: "Senha",
            hintStyle: TextStyle(color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            prefixIcon: Icon(Icons.lock, color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: _isDarkMode ? Colors.grey[400] : Colors.grey[500],
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        const SizedBox(height: 15),

        // Remember me and forgot password
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Text(
              "Manter conectado",
              style: TextStyle(color: _isDarkMode ? Colors.grey[300] : Colors.grey[600]),
            ),
            const Spacer(),
            TextButton(
              onPressed: _showForgotPasswordDialog,
              child: Text(
                "Esqueci a senha",
                style: TextStyle(color: _isDarkMode ? Colors.grey[300] : Colors.grey[600]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Login button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF65B6FB),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              disabledBackgroundColor: Colors.blue.withOpacity(0.7),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    "Entrar",
                    style: TextStyle(fontSize: 16),
                  ),
          ),
        ),
        const SizedBox(height: 20),

        // Social login
      ],
    );
  }

  // Build the register tab
  Widget _buildRegisterTab() {
    return Column(
      children: [
        // User avatar with add icon
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: _isDarkMode ? Colors.grey[700] : Colors.grey[300],
              child: Icon(
                Icons.person,
                size: 50,
                color: _isDarkMode ? Colors.grey[400] : Colors.grey[500],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.blue,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add, size: 20, color: Colors.white),
                  onPressed: () => _showInfoDialog('Adicionar foto de perfil'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Name field
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: _isDarkMode ? Colors.grey[700] : Colors.grey[200],
            hintText: "Nome completo",
            hintStyle: TextStyle(color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            prefixIcon: Icon(Icons.person, color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        const SizedBox(height: 15),

        // Email field
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: _isDarkMode ? Colors.grey[700] : Colors.grey[200],
            hintText: "E-mail",
            hintStyle: TextStyle(color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            prefixIcon: Icon(Icons.email, color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        const SizedBox(height: 15),

        // Password field
        TextField(
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            filled: true,
            fillColor: _isDarkMode ? Colors.grey[700] : Colors.grey[200],
            hintText: "Senha",
            hintStyle: TextStyle(color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            prefixIcon: Icon(Icons.lock, color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: _isDarkMode ? Colors.grey[400] : Colors.grey[500],
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        const SizedBox(height: 15),

        // Confirm password field
        TextField(
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            filled: true,
            fillColor: _isDarkMode ? Colors.grey[700] : Colors.grey[200],
            hintText: "Confirmar senha",
            hintStyle: TextStyle(color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            prefixIcon: Icon(Icons.lock, color: _isDarkMode ? Colors.grey[400] : Colors.grey[500]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        const SizedBox(height: 25),

        // Register button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _showInfoDialog('Funcionalidade de registro será implementada em breve'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF65B6FB),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Registrar",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  // Duck SVG string
  final String _duckSvgString = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 300">
  <!-- Duck base shape -->
  <defs>
    <radialGradient id="headGradient" cx="50%" cy="40%" r="60%" fx="50%" fy="40%">
      <stop offset="0%" stop-color="#36A058" />
      <stop offset="100%" stop-color="#2A7E45" />
    </radialGradient>
    <linearGradient id="billGradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#FFA500" />
      <stop offset="100%" stop-color="#FF8C00" />
    </linearGradient>
  </defs>
  
  <!-- Crown/cap on duck's head -->
  <ellipse cx="150" cy="100" rx="70" ry="25" fill="#FF9800" stroke="#E65100" stroke-width="2" />
  <path d="M150 105 C180 90, 220 90, 220 115 C220 130, 180 140, 150 135 Z" fill="#FFB74D" />
  
  <!-- Dots around the crown -->
  <circle cx="110" cy="90" r="5" fill="#3F51B5" />
  <circle cx="125" cy="85" r="5" fill="#3F51B5" />
  <circle cx="140" cy="82" r="5" fill="#3F51B5" />
  <circle cx="158" cy="82" r="5" fill="#3F51B5" />
  <circle cx="175" cy="85" r="5" fill="#3F51B5" />
  <circle cx="190" cy="90" r="5" fill="#3F51B5" />
  
  <!-- Text on the crown -->
  <text x="130" y="105" font-family="Arial" font-size="12" font-weight="bold" fill="#2E7D32">QUACKLOADS</text>
  
  <!-- Body -->
  <ellipse cx="150" cy="200" rx="80" ry="60" fill="white" stroke="#EEEEEE" stroke-width="2" />
  
  <!-- Wings -->
  <path d="M210 180 C250 120, 270 120, 240 180 C225 210, 210 200, 210 180 Z" fill="white" stroke="#EEEEEE" stroke-width="2" />
  <path d="M230 170 C240 165, 250 155, 245 165 M235 180 C245 175, 255 165, 250 175" stroke="#DDDDDD" stroke-width="2" />
  
  <!-- Brown markings on body -->
  <path d="M150 160 C170 160, 200 170, 190 210 C180 230, 150 220, 150 210 Z" fill="#8D6E63" />
  <path d="M120 170 C110 180, 100 200, 110 220 C120 230, 140 220, 140 210 Z" fill="#8D6E63" />
  
  <!-- Head -->
  <circle cx="150" cy="130" r="40" fill="url(#headGradient)" />
  
  <!-- Eyes -->
  <circle cx="135" cy="120" r="8" fill="white" />
  <circle cx="135" cy="120" r="4" fill="black" />
  <circle cx="134" cy="118" r="2" fill="white" />
  
  <!-- Bill -->
  <path d="M140 140 C155 135, 170 138, 190 145 C200 150, 200 160, 190 165 C170 175, 150 170, 140 165 Z" fill="url(#billGradient)" stroke="#E65100" stroke-width="1" />
  
  <!-- Open mouth -->
  <path d="M160 152 C180 155, 185 160, 175 167 C160 172, 150 165, 160 152 Z" fill="#FF5252" stroke="#D50000" stroke-width="1" />
</svg>
  ''';
}

class FortyByFortyDisplay extends StatelessWidget {
  const FortyByFortyDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 40
          Container(
            width: 40,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: const Text(
              "40",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // X
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            child: const Text(
              "X",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),

          // 40
          Container(
            width: 40,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: const Text(
              "40",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
