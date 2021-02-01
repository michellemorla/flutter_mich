
import 'package:flutter/material.dart';
import 'package:flutter_mich/translations/translations.dart';

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate({this.isTest = false});
  final bool isTest;

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale, isTest: isTest);
    if(isTest){
      await translations.loadTest(locale);
    } else {
      await translations.load();
    }

    debugPrint('Load language: ${locale.languageCode}');

    return translations;
  }

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}