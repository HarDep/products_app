import 'package:flutter/material.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/domain/repository/local_storage_repository.dart';

class FavoritesProvider extends ChangeNotifier {
  List<ProductInfo> favorites = [];
  final LocalRepositoryInterface localRepositoryInterface;

  FavoritesProvider({required this.localRepositoryInterface});

  void loadFavorites() async {
    favorites = await localRepositoryInterface.getFavorites();
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
}
