import 'package:flutter/material.dart';
import 'package:products_app/domain/models/user.dart';
import '../../domain/repository/repositories.dart';

enum UserStatus { identified, unidentified }

class HomeProvider extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  User? user;
  int indexSelected = 0;
  bool? isDark;
  var userStatus = UserStatus.identified;

  HomeProvider({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  void loadUser() async {
    user = await localRepositoryInterface.getUser();
    userStatus = UserStatus.identified;
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

  Future<void> logOut() async {
    userStatus = UserStatus.unidentified;
    notifyListeners();
    final token = await localRepositoryInterface.getToken();
    await apiRepositoryInterface.logout(token!);
    await localRepositoryInterface.cleanInfo();
  }
}
