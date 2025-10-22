import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../common/styles/app_styles.dart';
import '../../../../../../common/widget/custom_button.dart';
import '../../../../../data/models/professor_model.dart';

class AddProfessorDialog extends StatefulWidget {
  final Function(ProfessorModel) onSave;

  const AddProfessorDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  State<AddProfessorDialog> createState() => _AddProfessorDialogState();
}

class _AddProfessorDialogState extends State<AddProfessorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _especialidadeController = TextEditingController();
  final _bioController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _especialidadeController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.radiusLarge),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
        padding: const EdgeInsets.all(AppStyles.largeSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person_add, color: AppStyles.primaryBlue),
                const SizedBox(width: AppStyles.smallSpace),
                const Text(
                  'Adicionar Professor',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppStyles.grey900,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppStyles.grey400),
                ),
              ],
            ),
            const SizedBox(height: AppStyles.mediumSpace),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nomeController,
                        label: 'Nome Completo',
                        hint: 'Digite o nome completo do professor',
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nome é obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppStyles.mediumSpace),
                      _buildTextField(
                        controller: _cpfController,
                        label: 'CPF',
                        hint: '000.000.000-00',
                        icon: Icons.badge,
                        keyboardType: TextInputType.number,
                        inputFormatters: [_cpfFormatter()],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'CPF é obrigatório';
                          }
                          if (value.length != 14) {
                            return 'CPF deve ter 11 dígitos';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppStyles.mediumSpace),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'professor@email.com',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email é obrigatório';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Email inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppStyles.mediumSpace),
                      _buildTextField(
                        controller: _telefoneController,
                        label: 'Telefone',
                        hint: '(00) 00000-0000',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [_phoneFormatter()],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Telefone é obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppStyles.mediumSpace),
                      _buildTextField(
                        controller: _especialidadeController,
                        label: 'Especialidade',
                        hint: 'Ex: Beach Tennis Avançado',
                        icon: Icons.sports_tennis,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Especialidade é obrigatória';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppStyles.mediumSpace),
                      _buildTextField(
                        controller: _bioController,
                        label: 'Biografia (Opcional)',
                        hint: 'Breve descrição sobre o professor',
                        icon: Icons.description,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppStyles.mediumSpace),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancelar',
                    onPressed: () => Navigator.pop(context),
                    type: ButtonType.secondary,
                  ),
                ),
                const SizedBox(width: AppStyles.mediumSpace),
                Expanded(
                  child: CustomButton(
                    text: _isLoading ? 'Salvando...' : 'Salvar',
                    onPressed: _isLoading ? null : _saveProfessor,
                    type: ButtonType.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppStyles.primaryBlue),
        filled: true,
        fillColor: AppStyles.grey50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
          borderSide: const BorderSide(color: AppStyles.grey200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
          borderSide: const BorderSide(color: AppStyles.grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
          borderSide: const BorderSide(color: AppStyles.primaryBlue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  TextInputFormatter _cpfFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text.replaceAll(RegExp(r'\D'), '');
      
      if (text.length > 11) {
        text = text.substring(0, 11);
      }
      
      if (text.length >= 4) {
        text = '${text.substring(0, 3)}.${text.substring(3)}';
      }
      if (text.length >= 8) {
        text = '${text.substring(0, 7)}.${text.substring(7)}';
      }
      if (text.length >= 12) {
        text = '${text.substring(0, 11)}-${text.substring(11)}';
      }
      
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }

  TextInputFormatter _phoneFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text.replaceAll(RegExp(r'\D'), '');
      
      if (text.length > 11) {
        text = text.substring(0, 11);
      }
      
      if (text.length >= 3) {
        text = '(${text.substring(0, 2)}) ${text.substring(2)}';
      }
      if (text.length >= 10) {
        text = '${text.substring(0, 9)}-${text.substring(9)}';
      }
      
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }

  void _saveProfessor() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final professor = ProfessorModel(
        id: 0, // Será atribuído pelo backend
        nome: _nomeController.text.trim(),
        cpf: _cpfController.text.replaceAll(RegExp(r'\D'), ''),
        email: _emailController.text.trim().toLowerCase(),
        telefone: _telefoneController.text.replaceAll(RegExp(r'\D'), ''),
        especialidade: _especialidadeController.text.trim(),
        ativo: true,
        usuarioId: 0, // Será atribuído pelo backend
        arenasIds: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      widget.onSave(professor);
      Navigator.pop(context);
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar professor: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}