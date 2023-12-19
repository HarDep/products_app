import 'package:flutter/material.dart';
import 'package:products_app/configs/themes.dart';
import 'package:products_app/domain/repository/local_storage_repository.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme = lightTheme;
  final LocalRepositoryInterface localRepositoryInterface;

  ThemeProvider({required this.localRepositoryInterface});

  void loadTheme() async {
    final isDark = await localRepositoryInterface.getIsDarkMode();
    updateTheme(isDark);
  }

  void updateTheme(bool isDark) {
    currentTheme = isDark ? darkTheme : lightTheme;
    notifyListeners();
  }
}
