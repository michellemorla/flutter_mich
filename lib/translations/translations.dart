
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Translations {
  Translations(this.locale, {this.isTest = false});

  final Locale locale;
  final bool isTest;
  Map<String, String> _sentences;

  static Translations of(BuildContext context){
    return Localizations.of<Translations>(context, Translations);
  }

  Future<Translations> loadTest(Locale locale) async {
    return Translations(locale);
  }

  Future<Translations> load() async {
    String data = await rootBundle.loadString('assets/locale/i18n_${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    this._sentences = Map();
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });

    return Translations(locale);
  }

  String trans(String key){
    if (isTest) return key;

    if (key == null) {
      return '...';
    }
    return this._sentences[key];
  }

}