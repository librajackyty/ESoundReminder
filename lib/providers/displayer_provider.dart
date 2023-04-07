import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/displayer.dart';
import '../utils/text_config.dart';

class DisplayerProvider extends ChangeNotifier {
  static const String scaleFactorKeyname = "appTxtSize";
  String _initialSize = Displayer.codeSizeL;
  String _size = Displayer.codeSizeL;
  String get size => _size;

  DisplayerProvider();

  fetchAppTextSize() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(scaleFactorKeyname) == null) {
      debugPrint("appScaleFactor no data");
      return false;
    }
    _size = prefs.getString(scaleFactorKeyname) ?? _initialSize;
    debugPrint("fetchSize : $_size");

    updateAppTxtSize(size: fromSizeValToType(_size));
    return true;
  }

  void saveAppTextSize(String newSize) async {
    if (_size == newSize) {
      return;
    }
    var prefs = await SharedPreferences.getInstance();
    debugPrint("changeTextSize : $newSize");
    debugPrint("_scaleFactor : $_size");
    _size = newSize;
    await prefs.setString(scaleFactorKeyname, _size);
    notifyListeners();
  }

  // Time picker
  static const String timepickerStyleKeyname = "timepickerStyle";
  int _defaultTimepickerStyle = Displayer.codeTimepickerStyle1;
  int _timepickerStyle = Displayer.codeTimepickerStyle1;
  int get timepickerStyle => _timepickerStyle;

  fetchTimepickerStyle() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getInt(timepickerStyleKeyname) == null) {
      debugPrint("timepickerStyle no data");
      return false;
    }
    _timepickerStyle =
        prefs.getInt(timepickerStyleKeyname) ?? _defaultTimepickerStyle;
    debugPrint("timepickerStyle : $_timepickerStyle");
    return true;
  }

  void saveTimepickerStyle(int style) async {
    if (style < 1 || style > 2) {
      debugPrint("saveTimepickerStyle no style");
      return;
    }
    if (_timepickerStyle == style) {
      return;
    }
    var prefs = await SharedPreferences.getInstance();
    debugPrint("change style : $style");
    debugPrint("_timepickerStyle : $_timepickerStyle");
    _timepickerStyle = style;
    await prefs.setInt(timepickerStyleKeyname, _timepickerStyle);
    notifyListeners();
  }
}
