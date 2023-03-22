import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/language.dart';
import '../utils/constants.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale(Language.codeEnglish);
  Locale get appLocal => _appLocale;

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(langLangCodeKey) == null) {
      _appLocale = Locale(Language.codeEnglish);
      return Null;
    }
    _appLocale =
        Locale(prefs.getString(langLangCodeKey) ?? Language.codeEnglish);
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale(Language.codeTCantonese)) {
      _appLocale = Locale(Language.codeTCantonese);
      await prefs.setString(langLangCodeKey, Language.codeTCantonese);
      await prefs.setString(langCountryCodeKey, 'HK');
    } else if (type == Locale(Language.codeSChinese)) {
      _appLocale = Locale(Language.codeSChinese);
      await prefs.setString(langLangCodeKey, Language.codeSChinese);
      await prefs.setString(langCountryCodeKey, 'CN');
    } else {
      _appLocale = Locale(Language.codeEnglish);
      await prefs.setString(langLangCodeKey, Language.codeEnglish);
      await prefs.setString(langCountryCodeKey, 'US');
    }
    notifyListeners();
  }
}
