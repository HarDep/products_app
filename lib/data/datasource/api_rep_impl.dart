import 'package:products_app/data/memory_products.dart';
import 'package:products_app/domain/exception/auth_exception.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/models/product_cart.dart';
import 'package:products_app/domain/models/product_category.dart';
import 'package:products_app/domain/models/product_details.dart';
import 'package:products_app/domain/models/product_info.dart';
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

  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return products;
  }

  @override
  Future<void> buyProducts(List<ProductCart> products) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<List<ProductInfo>> getFamousProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return famous;
  }

  @override
  Future<List<ProductInfo>> getFamousProductsByCategory({String category = '',}) async {
    await Future.delayed(const Duration(seconds: 1));
    final productsFiltered = famous
        .where((prod) => prod.category.name.toUpperCase() == category.toUpperCase())
        .toList();
    return productsFiltered;
  }

  @override
  Future<List<Product>> getProductsByNameQuery(String query) async {
    await Future.delayed(const Duration(seconds: 2));
    final productsFiltered = products
        .where((prod) => prod.name.toUpperCase().contains(query.toUpperCase()))
        .toList();
    return productsFiltered;
  }

  @override
  Future<List<ProductInfo>> getRecommendedProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return recommended;
  }

  @override
  Future<List<ProductInfo>> getRecommendedProductsByCategory({String category = '',}) async {
    await Future.delayed(const Duration(seconds: 1));
    final productsFiltered = recommended
        .where((prod) => prod.category.name.toUpperCase() == category.toUpperCase())
        .toList();
    return productsFiltered;
  }

  @override
  Future<List<ProductCategory>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    return categories;
  }

  @override
  Future<ProductDetails> getProductDetails(Product product) async {
    final details =
        productDetails.firstWhere((elm) => elm.product.name == product.name);
    return details;
  }
  
  @override
  Future<List<ProductInfo>> getProductsByNameQueryAndCategory({required String query, required String category}) async {
    await Future.delayed(const Duration(seconds: 1));
    final productsFiltered = recommended //no es recommended lo uso porque igual hay estan todos los productos
        .where((prod) => prod.product.name.toUpperCase().contains(query.toUpperCase()) &&
        prod.category.name.toUpperCase() == category.toUpperCase())
        .toList();
    return productsFiltered;
  }
}
