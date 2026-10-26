import 'app_language.dart';

/// A piece of text available in every supported language.
class LocalizedText {
  const LocalizedText({required this.en, required this.hi});

  final String en;
  final String hi;

  /// Returns the text for [language]. Falls back to English if the Hindi text
  /// is empty so the user never sees a blank instruction.
  String of(AppLanguage language) {
    switch (language) {
      case AppLanguage.hindi:
        return hi.trim().isNotEmpty ? hi : en;
      case AppLanguage.english:
        return en;
    }
  }

  /// True when both translations are present.
  bool get isComplete => en.trim().isNotEmpty && hi.trim().isNotEmpty;
}
