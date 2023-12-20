import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/models/product_cart.dart';
import 'package:products_app/domain/models/user.dart';
import 'package:products_app/domain/request/login_request.dart';
import 'package:products_app/domain/response/login_response.dart';

abstract class ApiRepositoryInterface {
  Future<User> getUserFromToken(String token);
  Future<LoginResponse> login(LoginRequest login);
  Future<void> logout(String token);
  Future<List<Product>> getProducts();
  Future<void> buyProducts(List<ProductCart> products);
}
