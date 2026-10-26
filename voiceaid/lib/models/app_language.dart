/// Languages supported by VoiceAid.
enum AppLanguage {
  english('en', 'en-IN', 'English', 'EN'),
  hindi('hi', 'hi-IN', 'हिन्दी', 'हिं');

  const AppLanguage(this.code, this.ttsLocale, this.nativeName, this.shortLabel);

  /// Used in asset paths, e.g. assets/audio/hi/...
  final String code;

  /// Locale passed to the text-to-speech engine.
  final String ttsLocale;

  /// Name written in the language itself.
  final String nativeName;

  /// Very short label for compact selectors.
  final String shortLabel;

  /// Safe lookup from a stored code. Unknown/null values fall back to English.
  static AppLanguage fromCode(String? code) {
    for (final l in AppLanguage.values) {
      if (l.code == code) return l;
    }
    return AppLanguage.english;
  }
}
