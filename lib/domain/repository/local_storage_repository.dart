import 'package:products_app/domain/models/user.dart';

abstract class LocalRepositoryInterface {
  Future<String?> getToken();
  Future<String?> saveToken(String token);
  Future<void> cleanInfo();
  Future<User?> saveUser(User user);
  Future<User?> getUser();
  Future<bool> getIsDarkMode();
  Future<void> saveIsDarkMode(bool isDarkMode);
}
