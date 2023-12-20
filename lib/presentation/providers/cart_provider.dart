import 'package:flutter/material.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/models/product_cart.dart';
import 'package:products_app/domain/repository/repositories.dart';

enum ProductsState { inCart, inPurchase }

class CartProvider extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  List<ProductCart> cart = [];
  int totalItems = 0;
  double totalPrice = 0;
  ProductsState state = ProductsState.inCart;

  CartProvider({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  //micronotificadores con value notifier?

  void loadCart() async {
    cart = await localRepositoryInterface.getCart();
    totalItems = cart.fold(0, (sum, prod) => prod.amount + sum);
    totalPrice =
        cart.fold(0, (sum, prod) => prod.amount * prod.product.price + sum);
    notifyListeners();
  }

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
    localRepositoryInterface.saveCart(cart);
  }

  void increment(ProductCart productCart) {
    productCart.amount++;
    totalItems++;
    totalPrice += productCart.product.price;
    notifyListeners();
    localRepositoryInterface.saveCart(cart);
  }

  void decrement(ProductCart productCart) {
    if (productCart.amount > 1) {
      productCart.amount--;
      totalItems--;
      totalPrice -= productCart.product.price;
      notifyListeners();
      localRepositoryInterface.saveCart(cart);
      return;
    }
    delete(productCart);
  }

  void delete(ProductCart productCart) {
    totalItems -= productCart.amount;
    totalPrice -= productCart.product.price * productCart.amount;
    cart.remove(productCart);
    notifyListeners();
    localRepositoryInterface.saveCart(cart);
  }

  Future<void> buyProducts() async {
    state = ProductsState.inPurchase;
    notifyListeners();
    await apiRepositoryInterface.buyProducts(cart);
    cart.clear();
    totalItems = 0;
    totalPrice = 0;
    localRepositoryInterface.saveCart(cart);
    state = ProductsState.inCart;
    notifyListeners();
  }
}
