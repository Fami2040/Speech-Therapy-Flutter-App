import 'dart:async';

class LanguageManager {
  static String currentLanguage = 'english'; // Default language

  static final StreamController<String> _languageChangeController = StreamController<String>.broadcast();

  static Stream<String> get onLanguageChange => _languageChangeController.stream;

  static void setLanguage(String language) {
    currentLanguage = language;
    // Trigger language change event
    _languageChangeController.add(language);
  }
}
