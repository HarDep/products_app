import 'package:flutter/material.dart';
import '../../domain/repository/repositories.dart';

class SplashProvider extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  SplashProvider(
      {required this.localRepositoryInterface,
      required this.apiRepositoryInterface});

  Future<bool> validateSesion() async {
    final String? token = await localRepositoryInterface.getToken();
    if (token != null) {
      final user = await apiRepositoryInterface.getUserFromToken(token);
      await localRepositoryInterface.saveUser(user);
      return true;
    }
    await Future.delayed(const Duration(seconds: 2));
    return false;
  }
}
