import 'dart:async';

import 'package:flutter/material.dart';
import 'package:products_app/domain/models/load_status.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/domain/repository/local_storage_repository.dart';

class FavoritesProvider extends ChangeNotifier {
  List<ProductInfo> favorites = [];
  final LocalRepositoryInterface localRepositoryInterface;
  LoadStatus loadStatus = LoadStatus.loading;
  Timer? debouncerTimer;

  final StreamController<List<ProductInfo>?> _resultsController =
      StreamController.broadcast();

  FavoritesProvider({required this.localRepositoryInterface});

  Stream<List<ProductInfo>?> get resultsStream => _resultsController.stream;

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

  void rebootDebouncerTimer(String query) {
    debouncerTimer = Timer(const Duration(milliseconds: 500), () {
      searchFavoriteQuery(query);
      debouncerTimer!.cancel();
    });
  }

  void cancelDebouncerTimer() {
    debouncerTimer!.cancel();
  }

  void showLoadQuery() {
    _resultsController.add(null);
  }

  void searchFavoriteQuery(String query, [int millisecondsDelay = 0]) async {
    //delay ya que el metodo de busqueda retorna la lista antes de que se haga el build
    if (millisecondsDelay == 0) {
      await Future.delayed(Duration.zero);
    } else {
      await Future.delayed(Duration(milliseconds: millisecondsDelay));
    }
    final result = favorites
        .where((elm) =>
            elm.product.name.toUpperCase().contains(query.toUpperCase()))
        .toList();
    _resultsController.add(result);
  }
}
