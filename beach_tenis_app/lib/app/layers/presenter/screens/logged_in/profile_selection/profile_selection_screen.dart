import 'package:beach_tenis_app/app/common/styles/app_styles.dart';
import 'package:beach_tenis_app/app/common/widget/custom_app_bar.dart';
import 'package:beach_tenis_app/app/common/widget/gradient_background.dart';
import 'package:beach_tenis_app/app/common/widget/profile_card.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/logged_in/arena_dashboard/arena_dashboard_screen.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/logged_in/athlete_registration/athlete_registration_screen.dart';
import 'package:beach_tenis_app/app/layers/presenter/screens/logged_in/subscription_selection/subscription_selection_screen.dart';
import 'package:beach_tenis_app/navigation.dart';
import 'package:flutter/material.dart';

class ProfileSelectionScreen extends StatefulWidget {
  const ProfileSelectionScreen({Key? key}) : super(key: key);

  static const String route = "profile-selection";

  @override
  State<ProfileSelectionScreen> createState() => _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState extends State<ProfileSelectionScreen> {
  String? _selectedProfile;

  void _selectProfile(String profileType) {
    setState(() {
      _selectedProfile = profileType;
    });
  }

  void _continueToNextStep() {
    if (_selectedProfile != null) {
      if (_selectedProfile == 'arena') {
        push(context, const SubscriptionSelectionScreen());
      } else {
        push(context, const AthleteRegistrationScreen());
      }
    }
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
                title: 'Selecione seu Perfil',
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
                        'Qual é o seu perfil?',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Escolha a opção que melhor descreve você para personalizar sua experiência',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 40),

                      // Card Arena
                      ProfileCard(
                        title: 'Arena',
                        subtitle: 'Sou proprietário ou administrador de uma arena de beach tennis',
                        icon: Icons.location_city,
                        iconColor: AppStyles().primaryColor,
                        isSelected: _selectedProfile == 'arena',
                        onTap: () => _selectProfile('arena'),
                        features: const [
                          'Gerenciar quadras e horários',
                          'Controlar reservas e pagamentos',
                          'Acompanhar estatísticas da arena',
                          'Gerenciar professores e eventos',
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Card Atleta
                      ProfileCard(
                        title: 'Atleta',
                        subtitle: 'Sou jogador de beach tennis e quero acompanhar meu desempenho',
                        icon: Icons.sports_tennis,
                        iconColor: AppStyles().secondaryColor,
                        isSelected: _selectedProfile == 'atleta',
                        onTap: () => _selectProfile('atleta'),
                        features: const [
                          'Acompanhar estatísticas pessoais',
                          'Reservar quadras e aulas',
                          'Participar de torneios',
                          'Conectar com outros jogadores',
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Informações adicionais
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
                              Icons.info_outline,
                              color: Colors.white.withOpacity(0.8),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Você poderá alterar seu perfil posteriormente nas configurações do aplicativo.',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Botão Continuar
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _selectedProfile != null ? _continueToNextStep : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedProfile != null ? Colors.white : Colors.white.withOpacity(0.3),
                            foregroundColor:
                                _selectedProfile != null ? AppStyles().primaryColor : Colors.white.withOpacity(0.5),
                            elevation: _selectedProfile != null ? 8 : 0,
                            shadowColor: Colors.black.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'CONTINUAR',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              if (_selectedProfile != null) ...[
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

                      // Link para pular etapa (se necessário)
                      TextButton(
                        onPressed: () {
                          // Implementar lógica para pular seleção
                          push(context, const ArenaDashboardScreen());
                        },
                        child: Text(
                          'Pular por agora',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
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
}
