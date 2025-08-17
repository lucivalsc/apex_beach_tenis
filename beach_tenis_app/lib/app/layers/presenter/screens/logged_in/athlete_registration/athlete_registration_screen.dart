import 'package:beach_tenis_app/app/common/styles/app_styles.dart';
import 'package:beach_tenis_app/app/common/widget/custom_app_bar.dart';
import 'package:beach_tenis_app/app/common/widget/custom_button.dart';
import 'package:beach_tenis_app/app/common/widget/custom_text_field.dart';
import 'package:beach_tenis_app/app/common/widget/gradient_background.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/logged_in/arena_dashboard/arena_dashboard_screen.dart';
import 'package:beach_tenis_app/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AthleteRegistrationScreen extends StatefulWidget {
  const AthleteRegistrationScreen({Key? key}) : super(key: key);

  static const String route = "athlete-registration";

  @override
  State<AthleteRegistrationScreen> createState() => _AthleteRegistrationScreenState();
}

class _AthleteRegistrationScreenState extends State<AthleteRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentStep = 0;

  // Controladores dos campos
  final _fullNameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();
  final _instagramController = TextEditingController();
  final _observationsController = TextEditingController();

  // Estados dos campos
  String _selectedGender = 'M';
  String _selectedDominantHand = 'Destro';
  String _selectedExperienceLevel = 'Iniciante';
  String _selectedPosition = 'Ambos';
  bool _hasHealthIssues = false;
  bool _acceptsTerms = false;
  bool _acceptsDataUsage = false;

  final List<String> _experienceLevels = ['Iniciante', 'Intermediário', 'Avançado', 'Profissional'];

  final List<String> _positions = ['Fundo', 'Rede', 'Ambos'];

  @override
  void dispose() {
    _fullNameController.dispose();
    _cpfController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _emergencyContactController.dispose();
    _emergencyPhoneController.dispose();
    _instagramController.dispose();
    _observationsController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _acceptsTerms) {
      // Implementar lógica de cadastro
      push(context, const ArenaDashboardScreen());
    }
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName é obrigatório';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-mail é obrigatório';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? _validateCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'CPF é obrigatório';
    }
    if (value.replaceAll(RegExp(r'[^\d]'), '').length != 11) {
      return 'CPF deve ter 11 dígitos';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // App Bar customizada
              CustomAppBar(
                title: 'Cadastro do Atleta',
                showBackButton: true,
                onBackPressed: _currentStep > 0 ? _previousStep : null,
              ),

              // Indicador de progresso
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                        height: 4,
                        decoration: BoxDecoration(
                          color: index <= _currentStep ? Colors.white : Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Conteúdo das páginas
              Expanded(
                child: Form(
                  key: _formKey,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildPersonalInfoStep(),
                      _buildSportsInfoStep(),
                      _buildFinalStep(),
                    ],
                  ),
                ),
              ),

              // Botões de navegação
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: CustomButton(
                          text: 'VOLTAR',
                          onPressed: _previousStep,
                          type: ButtonType.secondary,
                        ),
                      ),
                    if (_currentStep > 0) const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: _currentStep == 2 ? 'FINALIZAR CADASTRO' : 'PRÓXIMO',
                        onPressed: _currentStep == 2 ? _submitForm : _nextStep,
                        type: ButtonType.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título da etapa
          const Text(
            'Informações Pessoais',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            'Passo 1 de 3',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          // Nome completo
          CustomTextField(
            controller: _fullNameController,
            labelText: 'Nome Completo',
            prefixIcon: const Icon(Icons.person),
            validator: (value) => _validateRequired(value, 'Nome completo'),
          ),

          const SizedBox(height: 16),

          // CPF
          CustomTextField(
            controller: _cpfController,
            labelText: 'CPF',
            prefixIcon: const Icon(Icons.badge),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction((oldValue, newValue) {
                String text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
                if (text.length <= 11) {
                  if (text.length > 3) text = '${text.substring(0, 3)}.${text.substring(3)}';
                  if (text.length > 7) text = '${text.substring(0, 7)}.${text.substring(7)}';
                  if (text.length > 11) text = '${text.substring(0, 11)}-${text.substring(11)}';
                }
                return TextEditingValue(
                  text: text,
                  selection: TextSelection.collapsed(offset: text.length),
                );
              }),
            ],
            validator: _validateCPF,
          ),

          const SizedBox(height: 16),

          // Data de nascimento
          CustomTextField(
            controller: _birthDateController,
            labelText: 'Data de Nascimento',
            prefixIcon: const Icon(Icons.calendar_today),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction((oldValue, newValue) {
                String text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
                if (text.length <= 8) {
                  if (text.length > 2) text = '${text.substring(0, 2)}/${text.substring(2)}';
                  if (text.length > 5) text = '${text.substring(0, 5)}/${text.substring(5)}';
                }
                return TextEditingValue(
                  text: text,
                  selection: TextSelection.collapsed(offset: text.length),
                );
              }),
            ],
            validator: (value) => _validateRequired(value, 'Data de nascimento'),
          ),

          const SizedBox(height: 16),

          // Gênero
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gênero',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Masculino', style: TextStyle(color: Colors.white)),
                        value: 'M',
                        groupValue: _selectedGender,
                        onChanged: (value) => setState(() => _selectedGender = value!),
                        activeColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Feminino', style: TextStyle(color: Colors.white)),
                        value: 'F',
                        groupValue: _selectedGender,
                        onChanged: (value) => setState(() => _selectedGender = value!),
                        activeColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Telefone
          CustomTextField(
            controller: _phoneController,
            labelText: 'Telefone',
            prefixIcon: const Icon(Icons.phone),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction((oldValue, newValue) {
                String text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
                if (text.length <= 11) {
                  if (text.length > 2) text = '(${text.substring(0, 2)}) ${text.substring(2)}';
                  if (text.length > 9) text = '${text.substring(0, 10)}-${text.substring(10)}';
                }
                return TextEditingValue(
                  text: text,
                  selection: TextSelection.collapsed(offset: text.length),
                );
              }),
            ],
            validator: (value) => _validateRequired(value, 'Telefone'),
          ),

          const SizedBox(height: 16),

          // E-mail
          CustomTextField(
            controller: _emailController,
            labelText: 'E-mail',
            prefixIcon: const Icon(Icons.email),
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
          ),
        ],
      ),
    );
  }

  Widget _buildSportsInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título da etapa
          const Text(
            'Informações Esportivas',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            'Passo 2 de 3',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          // Altura e Peso
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _heightController,
                  labelText: 'Altura (cm)',
                  prefixIcon: const Icon(Icons.height),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  controller: _weightController,
                  labelText: 'Peso (kg)',
                  prefixIcon: const Icon(Icons.monitor_weight),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Mão dominante
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mão Dominante',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Destro', style: TextStyle(color: Colors.white)),
                        value: 'Destro',
                        groupValue: _selectedDominantHand,
                        onChanged: (value) => setState(() => _selectedDominantHand = value!),
                        activeColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Canhoto', style: TextStyle(color: Colors.white)),
                        value: 'Canhoto',
                        groupValue: _selectedDominantHand,
                        onChanged: (value) => setState(() => _selectedDominantHand = value!),
                        activeColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Nível de experiência
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedExperienceLevel,
              decoration: InputDecoration(
                labelText: 'Nível de Experiência',
                prefixIcon: Icon(Icons.trending_up, color: AppStyles().primaryColor),
                border: InputBorder.none,
              ),
              items: _experienceLevels.map((level) {
                return DropdownMenuItem(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedExperienceLevel = value!;
                });
              },
            ),
          ),

          const SizedBox(height: 16),

          // Posição preferida
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedPosition,
              decoration: InputDecoration(
                labelText: 'Posição Preferida',
                prefixIcon: Icon(Icons.sports_tennis, color: AppStyles().primaryColor),
                border: InputBorder.none,
              ),
              items: _positions.map((position) {
                return DropdownMenuItem(
                  value: position,
                  child: Text(position),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPosition = value!;
                });
              },
            ),
          ),

          const SizedBox(height: 16),

          // Instagram
          CustomTextField(
            controller: _instagramController,
            labelText: 'Instagram (opcional)',
            prefixIcon: const Icon(Icons.camera_alt),
            hintText: '@seuusuario',
          ),

          const SizedBox(height: 16),

          // Problemas de saúde
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: CheckboxListTile(
              title: const Text(
                'Possuo algum problema de saúde ou lesão que possa afetar a prática esportiva',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              value: _hasHealthIssues,
              onChanged: (value) => setState(() => _hasHealthIssues = value ?? false),
              activeColor: AppStyles().primaryColor,
              checkColor: Colors.white,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título da etapa
          const Text(
            'Informações de Emergência',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            'Passo 3 de 3',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          // Contato de emergência
          CustomTextField(
            controller: _emergencyContactController,
            labelText: 'Contato de Emergência',
            prefixIcon: const Icon(Icons.emergency),
            validator: (value) => _validateRequired(value, 'Contato de emergência'),
          ),

          const SizedBox(height: 16),

          // Telefone de emergência
          CustomTextField(
            controller: _emergencyPhoneController,
            labelText: 'Telefone de Emergência',
            prefixIcon: const Icon(Icons.phone_in_talk),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction((oldValue, newValue) {
                String text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
                if (text.length <= 11) {
                  if (text.length > 2) text = '(${text.substring(0, 2)}) ${text.substring(2)}';
                  if (text.length > 9) text = '${text.substring(0, 10)}-${text.substring(10)}';
                }
                return TextEditingValue(
                  text: text,
                  selection: TextSelection.collapsed(offset: text.length),
                );
              }),
            ],
            validator: (value) => _validateRequired(value, 'Telefone de emergência'),
          ),

          const SizedBox(height: 16),

          // Observações
          CustomTextField(
            controller: _observationsController,
            labelText: 'Observações Médicas (opcional)',
            prefixIcon: const Icon(Icons.medical_information),
            maxLines: 3,
            hintText: 'Alergias, medicamentos, condições especiais...',
          ),

          const SizedBox(height: 30),

          // Termos e condições
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                CheckboxListTile(
                  title: GestureDetector(
                    onTap: () {
                      // Abrir termos de uso
                    },
                    child: const Text(
                      'Aceito os Termos de Uso e Política de Privacidade',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  value: _acceptsTerms,
                  onChanged: (value) => setState(() => _acceptsTerms = value ?? false),
                  activeColor: AppStyles().primaryColor,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                CheckboxListTile(
                  title: const Text(
                    'Autorizo o uso dos meus dados para análise de desempenho e estatísticas',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  value: _acceptsDataUsage,
                  onChanged: (value) => setState(() => _acceptsDataUsage = value ?? false),
                  activeColor: AppStyles().primaryColor,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),

          if (!_acceptsTerms)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'É necessário aceitar os termos para continuar',
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
