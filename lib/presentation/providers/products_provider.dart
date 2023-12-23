import 'dart:async';

import 'package:flutter/material.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/repository/api_repository.dart';

class ProductsProvider extends ChangeNotifier {
  final ApiRepositoryInterface apiRepositoryInterface;
  List<Product> products = [];

  final StreamController<List<Product>> _resultsController =
      StreamController.broadcast();

  ProductsProvider({required this.apiRepositoryInterface});

  Stream<List<Product>> get resultsStream => _resultsController.stream;

  void loadProducts() async {
    final result = await apiRepositoryInterface.getProducts();
    products = result;
    notifyListeners();
  }

  void searchProductsQuery(String query) async {
    final result = await apiRepositoryInterface.getProductsByNameQuery(query);
    _resultsController.add(result);
  }
}
