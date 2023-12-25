import 'dart:async';

import 'package:flutter/material.dart';
import 'package:products_app/domain/models/load_status.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/repository/api_repository.dart';

class ProductsProvider extends ChangeNotifier {
  final ApiRepositoryInterface apiRepositoryInterface;
  List<Product> products = [];
  LoadStatus loadStatus = LoadStatus.loading;

  final StreamController<List<Product>?> _resultsController =
      StreamController.broadcast();
  Timer? debouncerTimer;

  ProductsProvider({required this.apiRepositoryInterface});

  Stream<List<Product>?> get resultsStream => _resultsController.stream;

  void loadProducts() async {
    final result = await apiRepositoryInterface.getProducts();
    products = result;
    loadStatus = LoadStatus.founded;
    notifyListeners();
  }

  void rebootDebouncerTimer(String query) {
    debouncerTimer = Timer(const Duration(milliseconds: 500), () {
      searchProductsQuery(query);
      debouncerTimer!.cancel();
    });
  }

  void cancelDebouncerTimer() {
    debouncerTimer!.cancel();
  }

  void showLoadQuery() {
    _resultsController.add(null);
  }

  void searchProductsQuery(String query, [int millisecondsDelay = 0]) async {
    List<Product> result;
    if (millisecondsDelay == 0) {
      result = await apiRepositoryInterface.getProductsByNameQuery(query);
    } else {
      result = await apiRepositoryInterface.getProductsByNameQuery(query,
          delay: Duration(milliseconds: millisecondsDelay));
    }
    _resultsController.add(result);
  }
}
