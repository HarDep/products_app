import 'dart:async';

import 'package:flutter/material.dart';
import 'package:products_app/domain/models/load_status.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/domain/repository/local_storage_repository.dart';

class FavoritesProvider extends ChangeNotifier {
  List<ProductInfo> favorites = [];
  final LocalRepositoryInterface localRepositoryInterface;
  LoadStatus loadStatus = LoadStatus.loading;

  final StreamController<List<ProductInfo>> _resultsController =
      StreamController.broadcast();

  FavoritesProvider({required this.localRepositoryInterface});

  Stream<List<ProductInfo>> get resultsStream => _resultsController.stream;

  void loadFavorites() async {
    favorites = await localRepositoryInterface.getFavorites();
    loadStatus = LoadStatus.founded;
    notifyListeners();
  }

  void setFavoriteProduct(ProductInfo product) {
    bool isInFavorites = favorites
        .any((element) => element.product.name == product.product.name);
    if (!product.isFavorite && isInFavorites) {
      ProductInfo favorite = favorites.firstWhere(
          (element) => element.product.name == product.product.name);
      favorites.remove(favorite);
    }
    if (!isInFavorites && product.isFavorite) {
      favorites.add(product);
    }
    notifyListeners();
    localRepositoryInterface.saveFavorites(favorites);
  }

  void clearFavorites() {
    favorites.clear();
    notifyListeners();
  }

  void searchFavoriteQuery(String query) {
    final result = favorites
        .where((elm) =>
            elm.product.name.toUpperCase().contains(query.toUpperCase()))
        .toList();
    _resultsController.add(result);
  }
}
