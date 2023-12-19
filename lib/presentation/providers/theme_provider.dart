import 'package:flutter/material.dart';
import 'package:products_app/configs/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme = lightTheme;

  void loadTheme(){
    
  }

  void updateTheme(bool isDark) {
    currentTheme = isDark ? darkTheme : lightTheme;
    notifyListeners();
  }
}
