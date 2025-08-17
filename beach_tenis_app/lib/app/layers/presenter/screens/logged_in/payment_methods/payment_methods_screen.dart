import 'package:apex_sports/app/common/styles/app_styles.dart';
import 'package:apex_sports/app/common/widget/custom_app_bar.dart';
import 'package:apex_sports/app/common/widget/custom_button.dart';
import 'package:apex_sports/app/common/widget/custom_text_field.dart';
import 'package:apex_sports/app/common/widget/gradient_background.dart';
import 'package:apex_sports/app/layers/presenter/screens/logged_in/arena_dashboard/arena_dashboard_screen.dart';
import 'package:apex_sports/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  static const String route = "payment-methods";

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Controladores dos campos do cartão
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cpfController = TextEditingController();

  // Controladores dos campos PIX
  final _pixKeyController = TextEditingController();

  // Estados
  final String _selectedPaymentMethod = 'credit_card';
  String _selectedPixType = 'cpf';
  bool _saveCard = false;
  bool _acceptsTerms = false;

  // Dados do plano (normalmente viriam como argumentos)
  Map<String, dynamic> _planData = {
    'plan': 'profissional',
    'isAnnual': false,
    'price': 59.90,
    'name': 'Profissional',
  };

  final List<Map<String, dynamic>> _pixTypes = [
    {'value': 'cpf', 'label': 'CPF', 'icon': Icons.badge},
    {'value': 'email', 'label': 'E-mail', 'icon': Icons.email},
    {'value': 'phone', 'label': 'Telefone', 'icon': Icons.phone},
    {'value': 'random', 'label': 'Chave Aleatória', 'icon': Icons.key},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Recuperar dados do plano se passados como argumentos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          _planData = args;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cpfController.dispose();
    _pixKeyController.dispose();
    super.dispose();
  }

  void _processPayment() {
    if (_acceptsTerms) {
      // Implementar lógica de pagamento
      _showPaymentSuccessDialog();
    }
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppStyles().secondaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Pagamento Confirmado!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Seu teste gratuito de 14 dias foi ativado com sucesso.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  pushAndRemoveUntil(
                    context,
                    const ArenaDashboardScreen(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles().primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('COMEÇAR A USAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCardBrand(String cardNumber) {
    cardNumber = cardNumber.replaceAll(' ', '');
    if (cardNumber.startsWith('4')) return 'Visa';
    if (cardNumber.startsWith('5') || cardNumber.startsWith('2')) return 'Mastercard';
    if (cardNumber.startsWith('3')) return 'American Express';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // App Bar customizada
              const CustomAppBar(
                title: 'Forma de Pagamento',
                showBackButton: true,
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Resumo do plano
                      _buildPlanSummary(),

                      const SizedBox(height: 30),

                      // Seletor de método de pagamento
                      Container(
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
                            // Tab bar para métodos de pagamento
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
                                labelColor: AppStyles().primaryColor,
                                unselectedLabelColor: Colors.grey[600],
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                tabs: const [
                                  Tab(
                                    icon: Icon(Icons.credit_card),
                                    text: 'Cartão',
                                  ),
                                  Tab(
                                    icon: Icon(Icons.pix),
                                    text: 'PIX',
                                  ),
                                ],
                              ),
                            ),

                            // Conteúdo dos métodos de pagamento
                            SizedBox(
                              height: 400,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  _buildCreditCardForm(),
                                  _buildPixForm(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Termos e condições
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: CheckboxListTile(
                          title: GestureDetector(
                            onTap: () {
                              // Abrir termos de cobrança
                            },
                            child: const Text(
                              'Aceito os termos de cobrança e política de cancelamento',
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
                      ),

                      const SizedBox(height: 30),

                      // Botão de pagamento
                      CustomButton(
                        text: 'INICIAR TESTE GRATUITO',
                        onPressed: _acceptsTerms ? _processPayment : null,
                        type: ButtonType.primary,
                      ),

                      const SizedBox(height: 16),

                      // Informações de segurança
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.security,
                              color: Colors.white.withOpacity(0.7),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Seus dados estão protegidos com criptografia SSL',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppStyles().primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.business,
                  color: AppStyles().primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plano ${_planData['name']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _planData['isAnnual'] ? 'Cobrança anual' : 'Cobrança mensal',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'R\$ ${_planData['price'].toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppStyles().primaryColor,
                    ),
                  ),
                  Text(
                    _planData['isAnnual'] ? '/ano' : '/mês',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppStyles().secondaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppStyles().secondaryColor,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '14 dias grátis • Cancele a qualquer momento',
                    style: TextStyle(
                      color: AppStyles().secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditCardForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Número do cartão
          CustomTextField(
            controller: _cardNumberController,
            labelText: 'Número do Cartão',
            prefixIcon: const Icon(Icons.credit_card),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction((oldValue, newValue) {
                String text = newValue.text.replaceAll(' ', '');
                if (text.length <= 16) {
                  text = text
                      .replaceAllMapped(
                        RegExp(r'.{4}'),
                        (match) => '${match.group(0)} ',
                      )
                      .trim();
                }
                return TextEditingValue(
                  text: text,
                  selection: TextSelection.collapsed(offset: text.length),
                );
              }),
            ],
            suffixIcon: _cardNumberController.text.isNotEmpty
                ? Text(
                    _getCardBrand(_cardNumberController.text),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),

          const SizedBox(height: 16),

          // Nome no cartão
          CustomTextField(
            controller: _cardHolderController,
            labelText: 'Nome no Cartão',
            prefixIcon: const Icon(Icons.person),
            textCapitalization: TextCapitalization.characters,
          ),

          const SizedBox(height: 16),

          // Validade e CVV
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _expiryDateController,
                  labelText: 'Validade',
                  prefixIcon: const Icon(Icons.calendar_today),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      String text = newValue.text.replaceAll('/', '');
                      if (text.length <= 4) {
                        if (text.length > 2) text = '${text.substring(0, 2)}/${text.substring(2)}';
                      }
                      return TextEditingValue(
                        text: text,
                        selection: TextSelection.collapsed(offset: text.length),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  controller: _cvvController,
                  labelText: 'CVV',
                  prefixIcon: const Icon(Icons.security),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  obscureText: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // CPF do portador
          CustomTextField(
            controller: _cpfController,
            labelText: 'CPF do Portador',
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
          ),

          const SizedBox(height: 16),

          // Salvar cartão
          CheckboxListTile(
            title: const Text('Salvar cartão para próximas compras'),
            value: _saveCard,
            onChanged: (value) => setState(() => _saveCard = value ?? false),
            activeColor: AppStyles().primaryColor,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildPixForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tipo de chave PIX
          const Text(
            'Tipo de Chave PIX',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          // Seletor de tipo PIX
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _pixTypes.map((type) {
              final isSelected = _selectedPixType == type['value'];
              return GestureDetector(
                onTap: () => setState(() => _selectedPixType = type['value']),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppStyles().primaryColor : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? AppStyles().primaryColor : Colors.grey[300]!,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        type['icon'],
                        color: isSelected ? Colors.white : Colors.grey[600],
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        type['label'],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // Campo da chave PIX
          CustomTextField(
            controller: _pixKeyController,
            labelText: _getPixKeyLabel(),
            prefixIcon: Icon(_getPixKeyIcon()),
            keyboardType: _getPixKeyboardType(),
            inputFormatters: _getPixInputFormatters(),
          ),

          const SizedBox(height: 24),

          // Informações sobre PIX
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppStyles().secondaryColor3.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppStyles().secondaryColor3.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppStyles().primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Pagamento via PIX',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '• Pagamento instantâneo\n• Disponível 24h por dia\n• Sem taxas adicionais\n• Confirmação automática',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getPixKeyLabel() {
    switch (_selectedPixType) {
      case 'cpf':
        return 'CPF';
      case 'email':
        return 'E-mail';
      case 'phone':
        return 'Telefone';
      case 'random':
        return 'Chave Aleatória';
      default:
        return 'Chave PIX';
    }
  }

  IconData _getPixKeyIcon() {
    switch (_selectedPixType) {
      case 'cpf':
        return Icons.badge;
      case 'email':
        return Icons.email;
      case 'phone':
        return Icons.phone;
      case 'random':
        return Icons.key;
      default:
        return Icons.pix;
    }
  }

  TextInputType _getPixKeyboardType() {
    switch (_selectedPixType) {
      case 'cpf':
      case 'phone':
        return TextInputType.number;
      case 'email':
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> _getPixInputFormatters() {
    switch (_selectedPixType) {
      case 'cpf':
        return [
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
        ];
      case 'phone':
        return [
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
        ];
      default:
        return [];
    }
  }
}
