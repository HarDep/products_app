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
  Future<List<ProductInfo>> getFamousProductsByCategoryAndName(
      {required String category, String productName = ''});
  Future<List<ProductInfo>> getRecommendedProductsByCategoryAndName(
      {required String category, String productName = ''});
  Future<List<Product>> getProductsByName(String name);
  //y las sugerencias tambien? o de eso se encarga el provider
  //filtrar favoritos por query o que lo haga el provider
}
