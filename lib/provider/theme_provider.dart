import 'package:app_cham_cong_option_2/constant.dart';
import 'package:app_cham_cong_option_2/data/models/theme/theme_share_preferences.dart';
import 'package:flutter/material.dart';

//enum theme_mode { light, dark }

class ThemeProvider extends ChangeNotifier {
  ThemeSharePreferences themeSharePreferences = ThemeSharePreferences();

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    _themeMode = value;
    themeSharePreferences.setTheme(value);
    notifyListeners();
  }
}

class MyThemes {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      //phải thêm primary trong đây mới chịu nhận
      colorScheme: const ColorScheme.light().copyWith(
          primary:
              kBackgroundColor), // màu của text sẽ phụ thuộc vào cái này light màu đen và dark màu trắng
      primaryColor: kBackgroundColor,
      //primarySwatch: Colors.orange,
      primaryColorDark: Colors.white,
      appBarTheme: const AppBarTheme(backgroundColor: kBackgroundColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          //color của button
          backgroundColor: kBackgroundColor,
          //foregroundColor: color của icon,
          foregroundColor: Colors.white)
      //floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: )
      );
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.light().copyWith(
          primary:
              kBackgroundColor), // màu của text sẽ phụ thuộc vào cái này light màu đen và dark màu trắng
      primaryColor: Colors.black,
      // primaryColorLight: Colors.black,
      primaryColorDark: Colors.black,
      backgroundColor: kBackgroundColor,
      inputDecorationTheme: InputDecorationTheme(focusColor: kBackgroundColor),
      appBarTheme: const AppBarTheme(
        backgroundColor: kBackgroundColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          //color của button
          backgroundColor: kBackgroundColor,

          //foregroundColor: color của icon,
          foregroundColor: Colors.white));
}
