import 'package:flutter/material.dart';
import 'package:products_app/domain/models/product_category.dart';
import 'package:products_app/domain/models/product_info.dart';

import '../../domain/repository/repositories.dart';

class PrincipalProvider extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
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
}
