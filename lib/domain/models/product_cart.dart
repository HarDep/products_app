import 'package:products_app/domain/models/product.dart';

class ProductCart {
  final Product product;
  int amount = 1;

  ProductCart({required this.product});
}
