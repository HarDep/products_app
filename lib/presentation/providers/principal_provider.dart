import 'package:flutter/material.dart';
import 'package:products_app/domain/models/product_category.dart';
import 'package:products_app/domain/models/product_details.dart';
import 'package:products_app/domain/models/product_info.dart';

import '../../domain/repository/repositories.dart';

class PrincipalProvider extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  ProductDetails? currentDetails;
  ProductInfo? currentInfo;
  List<ProductCategory> categories = [];
  List<ProductInfo> famous = [];
  List<ProductInfo> recommended = [];

  PrincipalProvider({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  void loadLists() async {
    categories = await apiRepositoryInterface.getCategories();
    famous = await apiRepositoryInterface.getFamousProducts();
    recommended = await apiRepositoryInterface.getRecommendedProducts();
    await _putFavorites();
    notifyListeners();
  }

  Future<void> _putFavorites() async {
    final favorites = await localRepositoryInterface.getFavorites();
    for (var favorite in favorites) {
      for (var famous in famous) {
        if (famous.product.name == favorite.product.name) {
          famous.isFavorite = favorite.isFavorite;
          break;
        }
      }
      for (var recommended in recommended) {
        if (recommended.product.name == favorite.product.name) {
          recommended.isFavorite = favorite.isFavorite;
          break;
        }
      }
    }
  }

  //cuando ponga la seccion de categorias cada boton va a hacer el filtro de categoria y luego navigate.pop

  void _clearProductsLists() {
    famous = [];
    recommended = [];
    notifyListeners();
  }

  void setCurrentHeroProduct(ProductInfo product) async {
    currentInfo = product;
    currentDetails =
        await apiRepositoryInterface.getProductDetails(product.product);
    notifyListeners();
  }

  void setFavoriteProduct(ProductInfo product) {
    if (famous.any((element) => element.product.name == product.product.name)) {
      ProductInfo prod = famous.firstWhere(
          (element) => element.product.name == product.product.name);
      prod.isFavorite = product.isFavorite;
    }
    if (recommended
        .any((element) => element.product.name == product.product.name)) {
      ProductInfo prod = recommended.firstWhere(
          (element) => element.product.name == product.product.name);
      prod.isFavorite = product.isFavorite;
    }
    notifyListeners();
  }

  void setFavoriteAll() {
    for (var element in famous) {
      element.isFavorite = false;
    }
    for (var element in recommended) {
      element.isFavorite = false;
    }
    notifyListeners();
  }
}
