
import 'package:flutter/material.dart';
import 'package:flutter_mich/translations/translations.dart';

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en'].contains(locale.languageCode) || ['es'].contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    await translations.load();

    debugPrint('Load language: ${locale.languageCode}');

    return translations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<Translations> old) => false;
}