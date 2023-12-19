import 'package:products_app/domain/models/product.dart';

class ProductCart {
  final Product product;
  final int amount = 1;

  ProductCart({required this.product});

  set amount(int amount) => amount = amount;
}
