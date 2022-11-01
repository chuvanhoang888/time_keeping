import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSharePreferences {
  static const THEME_STATUS = "THEMESTATUS";

  setTheme(ThemeMode value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(THEME_STATUS, EnumToString.convertToString(value));
  }

  Future<ThemeMode> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mo = prefs.getString(THEME_STATUS) ?? "light";
    final mode = EnumToString.fromString(ThemeMode.values, mo)!;
    return mode;
  }
}
