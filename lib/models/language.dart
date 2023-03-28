import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Language {
  static const String codeEnglish = "en";
  static const String codeSChinese = "zh-chs";
  static const String codeTChinese = "zh-cht";
  static const String codeTCantonese = "zh-yue";
  static const Map<String, String> localeDisplay = {
    codeEnglish: "English",
    codeTCantonese: "粵語/廣東話",
    codeSChinese: "简体中文"
  };

  final Locale locale;

  Language(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static Language? of(BuildContext context) {
    return Localizations.of<Language>(context, Language);
  }

  static String currentLocale(BuildContext context) {
    return of(context)!.locale.languageCode;
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<Language> delegate = _LanguageDelegate();
  static const LocalizationsDelegate<MaterialLocalizations> fallbackMDelegate =
      _FallbackMLocalizationDelegate();
  static const LocalizationsDelegate<CupertinoLocalizations> fallbackCDelegate =
      _FallbackCLocalizationDelegate();

  Map<String, String> _localizedStrings = {};

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =
        await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String t(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class _LanguageDelegate extends LocalizationsDelegate<Language> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _LanguageDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return [
      Language.codeEnglish,
      Language.codeTCantonese,
      Language.codeSChinese
    ].contains(locale.languageCode);
  }

  @override
  Future<Language> load(Locale locale) async {
    // Language class is where the JSON loading actually runs
    Language localizations = Language(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_LanguageDelegate old) => false;
}

class _FallbackMLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _FallbackMLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      DefaultMaterialLocalizations();
  @override
  bool shouldReload(_) => false;
}

class _FallbackCLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _FallbackCLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<CupertinoLocalizations> load(Locale locale) async =>
      DefaultCupertinoLocalizations();
  @override
  bool shouldReload(_) => false;
}
