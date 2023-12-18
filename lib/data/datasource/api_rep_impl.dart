import 'package:products_app/domain/exception/auth_exception.dart';
import 'package:products_app/domain/models/user.dart';
import 'package:products_app/domain/repository/api_repository.dart';
import 'package:products_app/domain/request/login_request.dart';
import 'package:products_app/domain/response/login_response.dart';

class ApiReppositoryImpl extends ApiRepositoryInterface {
  @override
  Future<User> getUserFromToken(String token) async {
    await Future.delayed(const Duration(seconds: 2));
    if (token == 'A1') {
      return User(
          name: 'Carlos Perez',
          username: 'Carlitos1',
          image: 'assets/carlos.png');
    } else if (token == 'A2') {
      return User(
          name: 'Juan Lopez', username: 'Juanito1', image: 'assets/carlos.png');
    }
    throw AuthException();
  }

  @override
  Future<LoginResponse> login(LoginRequest login) async {
    await Future.delayed(const Duration(seconds: 1));
    if (login.username == 'Carlitos1' && login.password == '123') {
      final User user = User(
          name: 'Carlos Perez',
          username: 'Carlitos1',
          image: 'assets/carlos.png');
      return LoginResponse(user: user, token: 'A1');
    } else if (login.username == 'Juanito1' && login.password == '321') {
      final User user = User(
          name: 'Juan Lopez', username: 'Juanito1', image: 'assets/carlos.png');
      return LoginResponse(user: user, token: 'A2');
    }
    throw AuthException();
  }

  @override
  Future<void> logout(String token) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
