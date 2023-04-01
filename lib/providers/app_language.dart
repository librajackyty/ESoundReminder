import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/language.dart';
import '../utils/constants.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale(Language.codeEnglish);
  Locale get appLocal => _appLocale;
  bool _initalConfig = false;
  bool get isInitalConfig => _initalConfig;

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(langLangCodeKey) == null) {
      // _appLocale = Locale(Language.codeEnglish);
      debugPrint("Lang string no data");
      _initalConfig = true;
      return false;
    }
    _appLocale =
        Locale(prefs.getString(langLangCodeKey) ?? Language.codeEnglish);
    return true;
  }

  void changeLanguage(Locale type) async {
    _initalConfig = false;
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
