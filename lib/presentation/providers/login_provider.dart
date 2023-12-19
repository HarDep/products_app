import 'package:flutter/material.dart';
import 'package:products_app/domain/exception/auth_exception.dart';
import 'package:products_app/domain/request/login_request.dart';
import '../../domain/repository/repositories.dart';

enum LoginState {
  loading,
  initial,
}

class LoginProvider extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  var loginState = LoginState.initial;

  LoginProvider({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  Future<bool> login() async {
    final username = usernameTextController.text;
    final password = passwordTextController.text;
    try {
      loginState = LoginState.loading;
      notifyListeners();
      final loginResponse = await apiRepositoryInterface
          .login(LoginRequest(username: username, password: password));
      await localRepositoryInterface.saveToken(loginResponse.token);
      await localRepositoryInterface.saveUser(loginResponse.user);
      loginState = LoginState.initial;
      notifyListeners();
      return true;
    } on AuthException catch (_) {
      loginState = LoginState.initial;
      notifyListeners();
      return false;
    }
  }
}
