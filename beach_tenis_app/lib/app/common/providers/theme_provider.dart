import 'package:beach_tenis_app/app/common/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class ThemeProvider extends ChangeNotifier {
  static const String _themePreferenceKey = 'theme_mode';
  
  ThemeMode _themeMode = ThemeMode.light;
  
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  ThemeData get theme => isDarkMode ? AppStyles.darkTheme : AppStyles.lightTheme;
  
  // Gradiente para o fundo das telas
  LinearGradient get backgroundGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: isDarkMode 
      ? [const Color(0xFF2C3E50), const Color(0xFF1A252F)]
      : [AppStyles.lightBlue, AppStyles.primaryBlue],
  );
  
  ThemeProvider() {
    // Inicializa com o tema padrão e tenta carregar as preferências depois
    _initTheme();
  }
  
  void _initTheme() {
    try {
      _loadThemePreference();
    } catch (e) {
      developer.log('Erro ao carregar preferências de tema: $e');
      // Continua usando o tema padrão em caso de erro
    }
  }
  
  // Carrega a preferência de tema salva
  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString(_themePreferenceKey);
      
      if (savedTheme != null) {
        _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
        notifyListeners();
      }
    } catch (e) {
      developer.log('Erro ao carregar preferências de tema: $e');
      // Não faz nada em caso de erro, mantém o tema padrão
    }
  }
  
  // Salva a preferência de tema
  Future<void> _saveThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _themePreferenceKey, 
        isDarkMode ? 'dark' : 'light'
      );
    } catch (e) {
      developer.log('Erro ao salvar preferências de tema: $e');
      // Continua mesmo se não conseguir salvar
    }
  }
  
  // Alterna entre tema claro e escuro
  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _saveThemePreference();
    notifyListeners();
  }
  
  // Define um tema específico
  void setTheme(ThemeMode mode) {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    _saveThemePreference();
    notifyListeners();
  }
}
