import 'package:flutter/material.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/repository/api_repository.dart';

class ProductsProvider extends ChangeNotifier {
  final ApiRepositoryInterface apiRepositoryInterface;
  List<Product> products = [];
  List<Product> queryProducts = [];

  ProductsProvider({required this.apiRepositoryInterface});

  void loadProducts() async {
    final result = await apiRepositoryInterface.getProducts();
    products = result;
    notifyListeners();
  }

  void searchProducts(String query) async {
    queryProducts = await apiRepositoryInterface.getProductsByNameQuery(query);
    notifyListeners();
  }
}
