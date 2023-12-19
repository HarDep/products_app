import 'package:flutter/material.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/repository/api_repository.dart';

class ProductsProvider extends ChangeNotifier {
  final ApiRepositoryInterface apiRepositoryInterface;
  List<Product> products = [];

  ProductsProvider({required this.apiRepositoryInterface});

  void loadProducts() async {
    final result = await apiRepositoryInterface.getProducts();
    products = result;
    notifyListeners();
  }
}
