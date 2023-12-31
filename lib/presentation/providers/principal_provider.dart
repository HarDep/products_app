import 'dart:async';

import 'package:flutter/material.dart';
import 'package:products_app/domain/models/load_status.dart';
import 'package:products_app/domain/models/product_category.dart';
import 'package:products_app/domain/models/product_details.dart';
import 'package:products_app/domain/models/product_info.dart';

import '../../domain/repository/repositories.dart';

class PrincipalProvider extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  ProductDetails? currentDetails; //hero
  ProductInfo? currentInfo; //hero

  LoadStatus loadStatus = LoadStatus.loading;
  List<ProductCategory> categories = [];
  List<ProductInfo> famous = [];
  List<ProductInfo> recommended = [];
  Timer? debouncerTimer;

  final StreamController<List<ProductInfo>?> _resultsController =
      StreamController.broadcast();

  PrincipalProvider({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  Stream<List<ProductInfo>?> get resultsStream => _resultsController.stream;

  void loadLists() async {
    categories.add(ProductCategory(name: 'Todas', image: 'assets/todas.png'));
    final listCategories = await apiRepositoryInterface.getCategories();
    categories.addAll(listCategories);
    famous = await apiRepositoryInterface.getFamousProducts();
    recommended = await apiRepositoryInterface.getRecommendedProducts();
    await _putFavorites();
    loadStatus = LoadStatus.founded;
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

  void rebootDebouncerTimer(String query, [int categoryIndex = 0]) {
    debouncerTimer = Timer(const Duration(milliseconds: 500), () {
      searchProductsQuery(query, categoryIndex);
      debouncerTimer!.cancel();
    });
  }

  void cancelDebouncerTimer() {
    debouncerTimer!.cancel();
  }

  void searchProductsQuery(String query,
      [int categoryIndex = 0, int millisecondsDelay = 0]) async {
    final String category =
        categoryIndex == 0 ? '' : categories[categoryIndex].name;
    List<ProductInfo> result;
    if (millisecondsDelay == 0) {
      result = await apiRepositoryInterface.getProductsByNameQueryAndCategory(
          query: query, category: category);
    } else {
      result = await apiRepositoryInterface.getProductsByNameQueryAndCategory(
          query: query,
          category: category,
          delay: Duration(milliseconds: millisecondsDelay));
    }
    final favorites = await localRepositoryInterface.getFavorites();
    for (var favorite in favorites) {
      for (var prod in result) {
        if (prod.product.name == favorite.product.name) {
          prod.isFavorite = favorite.isFavorite;
          break;
        }
      }
    }
    _resultsController.add(result);
  }

  void showLoadQuery() {
    _resultsController.add(null);
  }

  void searchListsWithCategories([int categoryIndex = 0]) async {
    loadStatus = LoadStatus.loading;
    notifyListeners();
    final String category =
        categoryIndex == 0 ? '' : categories[categoryIndex].name;
    famous = await apiRepositoryInterface.getFamousProductsByCategory(
        category: category);
    recommended = await apiRepositoryInterface.getRecommendedProductsByCategory(
        category: category);
    await _putFavorites();
    loadStatus = LoadStatus.founded;
    notifyListeners();
  }
}
