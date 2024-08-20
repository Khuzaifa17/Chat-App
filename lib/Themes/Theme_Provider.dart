import 'package:c/Themes/Dark_Mode.dart';
import 'package:c/Themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightmode;
  ThemeData get themeData => _themeData;

  bool get isDarkmode => _themeData == Darkmode;

  set themedata(ThemeData themedata) {
    _themeData = themedata;
    notifyListeners();
  }

  void toggletTheme() {
    if (_themeData == lightmode) {
      themedata = Darkmode;
    } else {
      themedata = lightmode;
    }
  }
}
