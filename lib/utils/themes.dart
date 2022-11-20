import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/utils/style.dart';

class MyThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    backgroundColor: bgLightColor,
    primaryColor: primaryColor,
    accentColor: primaryColor,
  );
  static final darkTheem = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    backgroundColor: bgDarkColor,
    primaryColor: primaryColor,
    accentColor: primaryColor,
  );
}
