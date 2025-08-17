import 'package:beach_tenis_app/app/common/styles/app_styles.dart';
import 'package:beach_tenis_app/app/common/widget/custom_app_bar.dart';
import 'package:beach_tenis_app/app/common/widget/gradient_background.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/logged_in/payment_methods/payment_methods_screen.dart';
import 'package:flutter/material.dart';

class SubscriptionSelectionScreen extends StatefulWidget {
  const SubscriptionSelectionScreen({Key? key}) : super(key: key);

  static const String route = "subscription-selection";

  @override
  State<SubscriptionSelectionScreen> createState() => _SubscriptionSelectionScreenState();
}

class _SubscriptionSelectionScreenState extends State<SubscriptionSelectionScreen> {
  String? _selectedPlan;
  bool _isAnnual = false;

  final List<Map<String, dynamic>> _plans = [
    {
      'id': 'basico',
      'name': 'Básico',
      'monthlyPrice': 29.90,
      'annualPrice': 299.90,
      'description': 'Ideal para arenas pequenas',
      'features': [
        'Até 2 quadras',
        'Gestão básica de reservas',
        'Relatórios simples',
        'Suporte por email',
      ],
      'color': AppStyles().primaryColor,
      'icon': Icons.sports_tennis,
      'popular': false,
    },
    {
      'id': 'profissional',
      'name': 'Profissional',
      'monthlyPrice': 59.90,
      'annualPrice': 599.90,
      'description': 'Para arenas em crescimento',
      'features': [
        'Até 6 quadras',
        'Gestão completa de reservas',
        'Relatórios avançados',
        'Gestão de professores',
        'Suporte prioritário',
        'App personalizado',
      ],
      'color': AppStyles().primaryColor,
      'icon': Icons.business,
      'popular': true,
    },
    {
      'id': 'premium',
      'name': 'Premium',
      'monthlyPrice': 99.90,
      'annualPrice': 999.90,
      'description': 'Para grandes complexos',
      'features': [
        'Quadras ilimitadas',
        'Todas as funcionalidades',
        'Analytics avançados',
        'Integração com sistemas',
        'Suporte 24/7',
        'Consultoria especializada',
        'API personalizada',
      ],
      'color': AppStyles().primaryColor,
      'icon': Icons.diamond,
      'popular': false,
    },
  ];

  void _selectPlan(String planId) {
    setState(() {
      _selectedPlan = planId;
    });
  }

  void _toggleBilling() {
    setState(() {
      _isAnnual = !_isAnnual;
    });
  }

  void _continueToPayment() {
    if (_selectedPlan != null) {
      Navigator.pushNamed(context, PaymentMethodsScreen.route, arguments: {
        'plan': _selectedPlan,
        'isAnnual': _isAnnual,
      });
    }
  }

  double _getPrice(Map<String, dynamic> plan) {
    return _isAnnual ? plan['annualPrice'] : plan['monthlyPrice'];
  }

  double _getSavings(Map<String, dynamic> plan) {
    final monthlyTotal = plan['monthlyPrice'] * 12;
    final annualPrice = plan['annualPrice'];
    return monthlyTotal - annualPrice;
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
                title: 'Escolha seu Plano',
                showBackButton: true,
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Título e subtítulo
                      const Text(
                        'Selecione o plano ideal',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Escolha o plano que melhor atende às necessidades da sua arena',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 30),

                      // Toggle de cobrança
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _isAnnual = false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: !_isAnnual ? Colors.white : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Mensal',
                                    style: TextStyle(
                                      color: !_isAnnual ? AppStyles().primaryColor : Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _isAnnual = true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: _isAnnual ? Colors.white : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Anual',
                                        style: TextStyle(
                                          color: _isAnnual ? AppStyles().primaryColor : Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      if (_isAnnual)
                                        Text(
                                          'Economize até 17%',
                                          style: TextStyle(
                                            color: AppStyles().secondaryColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Cards de planos
                      ..._plans.map((plan) => _buildPlanCard(plan)).toList(),

                      const SizedBox(height: 30),

                      // Informações de teste gratuito
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_outline,
                              color: Colors.yellow[300],
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Teste gratuito de 14 dias',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Cancele a qualquer momento. Sem compromisso.',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Botão Continuar
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _selectedPlan != null ? _continueToPayment : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedPlan != null ? Colors.white : Colors.white.withOpacity(0.3),
                            foregroundColor:
                                _selectedPlan != null ? AppStyles().primaryColor : Colors.white.withOpacity(0.5),
                            elevation: _selectedPlan != null ? 8 : 0,
                            shadowColor: Colors.black.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'INICIAR TESTE GRATUITO',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              if (_selectedPlan != null) ...[
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Links de termos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Abrir termos de serviço
                            },
                            child: Text(
                              'Termos de Serviço',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Text(
                            ' • ',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Abrir política de privacidade
                            },
                            child: Text(
                              'Política de Privacidade',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    final isSelected = _selectedPlan == plan['id'];
    final price = _getPrice(plan);
    final savings = _getSavings(plan);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          // Card principal
          GestureDetector(
            onTap: () => _selectPlan(plan['id']),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? plan['color'] : Colors.transparent,
                  width: 2,
                ),
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
                  // Header do plano
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: plan['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          plan['icon'],
                          color: plan['color'],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppStyles().primaryColor,
                              ),
                            ),
                            Text(
                              plan['description'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Preço
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: plan['color'],
                            ),
                          ),
                          Text(
                            _isAnnual ? '/ano' : '/mês',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (_isAnnual && savings > 0)
                            Text(
                              'Economize R\$ ${savings.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppStyles.successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Features
                  ...plan['features']
                      .map<Widget>((feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: AppStyles.successColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
          ),

          // Badge "Mais Popular"
          if (plan['popular'])
            Positioned(
              top: -8,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppStyles().primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'MAIS POPULAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
