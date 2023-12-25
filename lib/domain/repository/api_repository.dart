import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/models/product_cart.dart';
import 'package:products_app/domain/models/product_category.dart';
import 'package:products_app/domain/models/product_details.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/domain/models/user.dart';
import 'package:products_app/domain/request/login_request.dart';
import 'package:products_app/domain/response/login_response.dart';

abstract class ApiRepositoryInterface {
  Future<User> getUserFromToken(String token);
  Future<LoginResponse> login(LoginRequest login);
  Future<void> logout(String token);
  Future<List<Product>> getProducts();
  Future<void> buyProducts(List<ProductCart> products);
  Future<List<ProductCategory>> getCategories();
  Future<ProductDetails> getProductDetails(Product product);
  Future<List<ProductInfo>> getFamousProducts();
  Future<List<ProductInfo>> getRecommendedProducts();
  Future<List<ProductInfo>> getFamousProductsByCategory({
    String category = '',
  });
  Future<List<ProductInfo>> getRecommendedProductsByCategory({
    String category = '',
  });
  Future<List<Product>> getProductsByNameQuery(String query,
      {Duration delay = Duration.zero});
  Future<List<ProductInfo>> getProductsByNameQueryAndCategory(
      {required String query,
      required String category,
      Duration delay = Duration.zero});
}
