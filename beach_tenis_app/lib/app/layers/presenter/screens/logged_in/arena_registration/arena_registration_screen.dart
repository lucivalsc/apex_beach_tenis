import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../common/widget/custom_app_bar.dart';
import '../../../../../common/widget/gradient_background.dart';
import '../../../../../common/widget/custom_text_field.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../../common/styles/app_styles.dart';

class ArenaRegistrationScreen extends StatefulWidget {
  const ArenaRegistrationScreen({Key? key}) : super(key: key);

  static const String route = "arena-registration";

  @override
  State<ArenaRegistrationScreen> createState() => _ArenaRegistrationScreenState();
}

class _ArenaRegistrationScreenState extends State<ArenaRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentStep = 0;
  
  // Controladores dos campos
  final _arenaNameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cepController = TextEditingController();
  final _addressController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instagramController = TextEditingController();
  final _facebookController = TextEditingController();
  final _websiteController = TextEditingController();

  // Estados dos campos
  bool _hasParking = false;
  bool _hasShower = false;
  bool _hasSnackBar = false;
  bool _hasEquipmentRental = false;
  bool _hasWifi = false;
  bool _hasAccessibility = false;
  int _numberOfCourts = 1;
  String _selectedState = 'SP';

  final List<String> _brazilianStates = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
    'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN',
    'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ];

  @override
  void dispose() {
    _arenaNameController.dispose();
    _cnpjController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cepController.dispose();
    _addressController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _descriptionController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();
    _websiteController.dispose();
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
    if (_formKey.currentState!.validate()) {
      // Implementar lógica de cadastro
      Navigator.pushNamed(context, '/payment-methods');
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

  String? _validateCNPJ(String? value) {
    if (value == null || value.isEmpty) {
      return 'CNPJ é obrigatório';
    }
    if (value.replaceAll(RegExp(r'[^\d]'), '').length != 14) {
      return 'CNPJ deve ter 14 dígitos';
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
                title: 'Cadastro da Arena',
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
                          color: index <= _currentStep 
                              ? Colors.white 
                              : Colors.white.withOpacity(0.3),
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
                      _buildBasicInfoStep(),
                      _buildAddressStep(),
                      _buildDetailsStep(),
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

  Widget _buildBasicInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título da etapa
          const Text(
            'Informações Básicas',
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

          // Nome da Arena
          CustomTextField(
            controller: _arenaNameController,
            labelText: 'Nome da Arena',
            prefixIcon: const Icon(Icons.business),
            validator: (value) => _validateRequired(value, 'Nome da Arena'),
          ),

          const SizedBox(height: 16),

          // CNPJ
          CustomTextField(
            controller: _cnpjController,
            labelText: 'CNPJ',
            prefixIcon: const Icon(Icons.business_center),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction((oldValue, newValue) {
                String text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
                if (text.length <= 14) {
                  if (text.length > 2) text = '${text.substring(0, 2)}.${text.substring(2)}';
                  if (text.length > 6) text = '${text.substring(0, 6)}.${text.substring(6)}';
                  if (text.length > 10) text = '${text.substring(0, 10)}/${text.substring(10)}';
                  if (text.length > 15) text = '${text.substring(0, 15)}-${text.substring(15)}';
                }
                return TextEditingValue(
                  text: text,
                  selection: TextSelection.collapsed(offset: text.length),
                );
              }),
            ],
            validator: _validateCNPJ,
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

          const SizedBox(height: 16),

          // Número de quadras
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
                Text(
                  'Número de Quadras',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      onPressed: _numberOfCourts > 1 
                          ? () => setState(() => _numberOfCourts--) 
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        '$_numberOfCourts quadra${_numberOfCourts > 1 ? 's' : ''}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() => _numberOfCourts++),
                      icon: const Icon(Icons.add_circle_outline),
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título da etapa
          const Text(
            'Endereço',
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

          // CEP
          CustomTextField(
            controller: _cepController,
            labelText: 'CEP',
            prefixIcon: const Icon(Icons.location_on),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction((oldValue, newValue) {
                String text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
                if (text.length <= 8) {
                  if (text.length > 5) text = '${text.substring(0, 5)}-${text.substring(5)}';
                }
                return TextEditingValue(
                  text: text,
                  selection: TextSelection.collapsed(offset: text.length),
                );
              }),
            ],
            validator: (value) => _validateRequired(value, 'CEP'),
          ),

          const SizedBox(height: 16),

          // Endereço
          CustomTextField(
            controller: _addressController,
            labelText: 'Endereço',
            prefixIcon: const Icon(Icons.home),
            validator: (value) => _validateRequired(value, 'Endereço'),
          ),

          const SizedBox(height: 16),

          // Número e Complemento
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomTextField(
                  controller: _numberController,
                  labelText: 'Número',
                  prefixIcon: const Icon(Icons.numbers),
                  validator: (value) => _validateRequired(value, 'Número'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: CustomTextField(
                  controller: _complementController,
                  labelText: 'Complemento (opcional)',
                  prefixIcon: const Icon(Icons.add_location),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Bairro
          CustomTextField(
            controller: _neighborhoodController,
            labelText: 'Bairro',
            prefixIcon: const Icon(Icons.location_city),
            validator: (value) => _validateRequired(value, 'Bairro'),
          ),

          const SizedBox(height: 16),

          // Cidade
          CustomTextField(
            controller: _cityController,
            labelText: 'Cidade',
            prefixIcon: const Icon(Icons.location_city),
            validator: (value) => _validateRequired(value, 'Cidade'),
          ),

          const SizedBox(height: 16),

          // Estado
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedState,
              decoration: const InputDecoration(
                labelText: 'Estado',
                prefixIcon: Icon(Icons.map, color: AppStyles.primaryBlue),
                border: InputBorder.none,
              ),
              items: _brazilianStates.map((state) {
                return DropdownMenuItem(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedState = value!;
                });
              },
              validator: (value) => _validateRequired(value, 'Estado'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título da etapa
          const Text(
            'Detalhes e Comodidades',
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

          // Descrição
          CustomTextField(
            controller: _descriptionController,
            labelText: 'Descrição da Arena (opcional)',
            prefixIcon: const Icon(Icons.description),
            maxLines: 3,
          ),

          const SizedBox(height: 24),

          // Comodidades
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
                Text(
                  'Comodidades Disponíveis',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildAmenityCheckbox('Estacionamento', _hasParking, (value) => setState(() => _hasParking = value)),
                _buildAmenityCheckbox('Vestiário/Chuveiro', _hasShower, (value) => setState(() => _hasShower = value)),
                _buildAmenityCheckbox('Lanchonete', _hasSnackBar, (value) => setState(() => _hasSnackBar = value)),
                _buildAmenityCheckbox('Aluguel de Equipamentos', _hasEquipmentRental, (value) => setState(() => _hasEquipmentRental = value)),
                _buildAmenityCheckbox('Wi-Fi', _hasWifi, (value) => setState(() => _hasWifi = value)),
                _buildAmenityCheckbox('Acessibilidade', _hasAccessibility, (value) => setState(() => _hasAccessibility = value)),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Redes sociais
          Text(
            'Redes Sociais (opcional)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _instagramController,
            labelText: 'Instagram',
            prefixIcon: const Icon(Icons.camera_alt),
            hintText: '@suaarena',
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _facebookController,
            labelText: 'Facebook',
            prefixIcon: const Icon(Icons.facebook),
            hintText: 'facebook.com/suaarena',
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _websiteController,
            labelText: 'Website',
            prefixIcon: const Icon(Icons.language),
            hintText: 'www.suaarena.com.br',
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityCheckbox(String title, bool value, Function(bool) onChanged) {
    return CheckboxListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      value: value,
      onChanged: (newValue) => onChanged(newValue ?? false),
      activeColor: AppStyles.primaryBlue,
      checkColor: Colors.white,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}
