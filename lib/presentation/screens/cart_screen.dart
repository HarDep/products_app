import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/product_cart.dart';
import 'package:products_app/presentation/providers/cart_provider.dart';
import 'package:products_app/presentation/widgets/avatar_clips.dart';
import 'package:products_app/presentation/widgets/custome_button.dart';
import 'package:products_app/presentation/widgets/product_items.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback goShopping;
  const CartScreen({super.key, required this.goShopping});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Carrito'),
      ),
      body: cartProvider.cart.isNotEmpty
          ? const _NotEmptyCart()
          : _EmptyCart(
              action: goShopping,
            ),
    );
  }
}

class _NotEmptyCart extends StatelessWidget {
  const _NotEmptyCart();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
            flex: 3,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              itemCount: cartProvider.cart.length,
              scrollDirection: Axis.horizontal,
              itemExtent: 250,
              itemBuilder: (context, index) {
                ProductCart product = cartProvider.cart[index];
                return _ShoppingProduct(product: product);
              },
            ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Theme.of(context).canvasColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SubTotal:',
                              style: TextStyle(
                                  color: Theme.of(context).iconTheme.color),
                            ),
                            Text(
                              '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Theme.of(context).iconTheme.color),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Envio:',
                              style: TextStyle(
                                  color: Theme.of(context).iconTheme.color),
                            ),
                            Text(
                              'Gratis',
                              style: TextStyle(
                                  color: Theme.of(context).iconTheme.color),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                  color: Theme.of(context).iconTheme.color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Theme.of(context).iconTheme.color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
                  CustomeButton(
                      textPadding: const EdgeInsets.symmetric(vertical: 17),
                      height: 55,
                      text: 'Realizar Compra',
                      voidCallback: () async {
                        await cartProvider.buyProducts();         
                        final snackBar = SnackBar(
                          content: const Text('Compra realizada con exito!', style: TextStyle(color: AppColors.white),),
                          action: SnackBarAction(
                            label: 'Ok',
                            onPressed: () {},
                          ),
                          duration: const Duration(seconds: 3),
                          backgroundColor: AppColors.green,
                        );
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ShoppingProduct extends StatelessWidget {
  final ProductCart product;

  const _ShoppingProduct({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        children: [
          Card(
            surfaceTintColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            color: Theme.of(context).canvasColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: CircleAvatar(
                      child: OvalAvatar(image: product.product.image),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      NameDescriptionsProductItems(product: product.product),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColors.lightGrey,
                                  borderRadius: BorderRadius.circular(5)),
                              child: InkWell(
                                  onTap: () {
                                    cartProvider.decrement(product);
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: AppColors.purple,
                                  ))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '${product.amount}',
                              style: const TextStyle(
                                  color: AppColors.lightGrey, fontSize: 17),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColors.purple,
                                  borderRadius: BorderRadius.circular(5)),
                              child: InkWell(
                                  onTap: () {
                                    cartProvider.increment(product);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                  ))),
                          const SizedBox(
                            width: 20,
                          ),
                          PriceProductItem(price: '\$${product.product.price.toStringAsFixed(1)}'),
                        ],
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: CircleAvatar(
              backgroundColor: AppColors.pink,
              child: IconButton(
                onPressed: () {
                  cartProvider.delete(product);
                },
                icon: const Icon(Icons.delete_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  final VoidCallback action;
  const _EmptyCart({required this.action});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/sad.png',
          color: AppColors.green,
          height: 120,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'No hay productos en tu carrito',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Center(
            child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.purple)),
          onPressed: action,
          child: const Text(
            'Ir a comprar',
            style: TextStyle(color: AppColors.white),
          ),
        )),
      ],
    );
  }
}
