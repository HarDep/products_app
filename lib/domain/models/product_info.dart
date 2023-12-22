import 'dart:convert';

import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/models/product_category.dart';

class ProductInfo {
  final Product product;
  bool isFavorite;
  final ProductCategory category;

  ProductInfo({
    required this.product,
    this.isFavorite = false,
    required this.category,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'product' : product.toMap(),
      'isFavorite' : isFavorite,
      'category' : category.toMap(),
    };
  }

  factory ProductInfo.fromMap(Map<String, dynamic> map) {
    return ProductInfo(
      product: Product.fromMap(map['product']),
      isFavorite: map['isFavorite'],
      category: ProductCategory.fromMap(map['category']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductInfo.fromJson(String source) => ProductInfo.fromMap(json.decode(source));
}
