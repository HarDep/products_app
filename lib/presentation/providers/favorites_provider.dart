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
    product.isFavorite = !product.isFavorite;
    if (!product.isFavorite) {
      favorites.remove(product);
    }
    notifyListeners();
  }
}
