import 'package:flutter/material.dart';
import 'package:products_app/domain/models/user.dart';
import '../../domain/repository/repositories.dart';

class HomeProvider extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  User? user;
  int indexSelected = 0;

  HomeProvider({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  void loadUser() async {
    user = await localRepositoryInterface.getUser();
    notifyListeners();
  }

  void updateIndex(int index) {
    indexSelected = index;
    notifyListeners();
  }
}
