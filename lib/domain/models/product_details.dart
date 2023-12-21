import 'package:products_app/domain/models/ingredient.dart';
import 'package:products_app/domain/models/product.dart';

class ProductDetails {
  final Product product;
  final List<Ingredient> ingredients;

  ProductDetails({required this.product, required this.ingredients});
}
