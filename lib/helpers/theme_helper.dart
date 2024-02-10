import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeHelper {

  static TextTheme _textTheme = TextTheme(
    // Title
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w800,),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),
    // Body
    bodySmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF7D7D7D)),
  );

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "YekanBakh",
      textTheme: _textTheme,
      iconTheme: IconThemeData(color: Color(0xFF0C5EDA)),
      dividerColor: Color(0xFFB6C2D2),
      hintColor: Color(0xFFA8A8A8),
      inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: Color(0xFFA8A8A8)),
      // Set color for suffix icon
      colorScheme: ColorScheme.light(
        primary: Color(0xFF702DFF),
        secondary: Color(0xFF0C5EDA),
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFF1F1F1),
        primaryContainer: Color(0xFFDAF2FF),
        tertiary: Color(0xFFF6F6F6), // It's textfield background color
      ));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xFF212121),
      fontFamily: "YekanBakh",
      textTheme: _textTheme,
      hintColor: Color(0xFFA8A8A8),
      // iconTheme in darkmode will be "white" by default.
      inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: Color(0xFFA8A8A8)),
      // Set color for suffix icon
      dividerColor: Color(0xFFB6C2D2),
      colorScheme: ColorScheme.dark(
        primary: Color(0xFF702DFF),
        secondary: Color(0xFF0C5EDA),
        secondaryContainer: Color(0xFF292929),
        primaryContainer: Color(0xFF00293E),
        tertiary: Color(0xFF333333),
        // It's textfield background color
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ));

  static void changeTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (Get.isDarkMode) {
      Get.changeTheme(lightTheme);
      prefs.setString('theme', 'light');
    } else {
      Get.changeTheme(darkTheme);
      prefs.setString('theme', 'dark');
    }
  }

  static Future<void> loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var theme = prefs.getString('theme');
    if (theme != null) {
      if (theme == "light") {
        Get.changeTheme(lightTheme);
      } else {
        if (theme == "dark") {
          Get.changeTheme(darkTheme);
        }
      }
    }
  }
}
