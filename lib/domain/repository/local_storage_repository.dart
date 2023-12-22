import 'package:products_app/domain/models/product_cart.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/domain/models/user.dart';

abstract class LocalRepositoryInterface {
  Future<String?> getToken();
  Future<String?> saveToken(String token);
  Future<void> cleanInfo();
  Future<User?> saveUser(User user);
  Future<User?> getUser();
  Future<bool> getIsDarkMode();
  Future<void> saveIsDarkMode(bool isDarkMode);
  Future<List<ProductCart>> getCart();
  Future<void> saveCart(List<ProductCart> cart);
  Future<List<ProductInfo>> getFavorites();
  Future<void> saveFavorites(List<ProductInfo> favorites);
}
