import 'package:flutter/material.dart';
import 'package:products_app/domain/models/user.dart';
import '../../domain/repository/repositories.dart';

class HomeProvider extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  User? user;
  int indexSelected = 0;
  bool? isDark;

  HomeProvider({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  void loadUser() async {
    user = await localRepositoryInterface.getUser();
    notifyListeners();
  }

  void loadTheme() async {
    isDark = await localRepositoryInterface.getIsDarkMode();
    notifyListeners();
  }

  void updateIndex(int index) {
    indexSelected = index;
    notifyListeners();
  }

  void updateTheme(bool isDarkValue) {
    localRepositoryInterface.saveIsDarkMode(isDarkValue);
    isDark = isDarkValue;
    notifyListeners();
  }

  void logOut() async {
    final token = await localRepositoryInterface.getToken();
    await apiRepositoryInterface.logout(token!);
    await localRepositoryInterface.cleanInfo();
  }
}
