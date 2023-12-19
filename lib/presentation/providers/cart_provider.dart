import 'package:flutter/material.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/models/product_cart.dart';

class CartProvider extends ChangeNotifier {
  List<ProductCart> cart = [];
  int totalItems = 0;
  double totalPrice = 0;

  //micronotificadores con value notifier?

  void add(Product product) {
    bool isFound = false;
    for (final prod in cart) {
      if (prod.product.name == product.name) {
        prod.amount++;
        isFound = true;
        break;
      }
    }
    if (!isFound) {
      cart.add(ProductCart(product: product));
    }
    totalItems++;
    totalPrice += product.price;
    notifyListeners();
  }

  void increment(ProductCart productCart) {
    productCart.amount++;
    totalItems++;
    totalPrice += productCart.product.price;
    notifyListeners();
  }

  void decrement(ProductCart productCart) {
    if (productCart.amount > 1) {
      productCart.amount--;
      totalItems--;
      totalPrice -= productCart.product.price;
      notifyListeners();
      return;
    }
    delete(productCart);
  }

  void delete(ProductCart productCart) {
    totalItems-=productCart.amount;
    totalPrice -= productCart.product.price*productCart.amount;
    cart.remove(productCart);
    notifyListeners();
  }
}
