import 'dart:convert';

import 'package:products_app/domain/models/product.dart';

class ProductCart {
  final Product product;
  int amount = 1;

  ProductCart({required this.product, this.amount = 1});

  Map<String, dynamic> toMap() {
    return {
      'amount' : amount,
      'product' : product.toMap(),
    };
  }

  factory ProductCart.fromMap(Map<String, dynamic> map) {
    return ProductCart(
      amount: map['amount'],
      product: Product.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCart.fromJson(String source) => ProductCart.fromMap(json.decode(source));
}
