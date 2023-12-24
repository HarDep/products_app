import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/load_status.dart';
import 'package:products_app/domain/models/product_cart.dart';
import 'package:products_app/presentation/providers/cart_provider.dart';
import 'package:products_app/presentation/widgets/avatar_clips.dart';
import 'package:products_app/presentation/widgets/custome_button.dart';
import 'package:products_app/presentation/widgets/custome_snack_bar.dart';
import 'package:products_app/presentation/widgets/empty_local_content.dart';
import 'package:products_app/presentation/widgets/loading_widgets.dart';
import 'package:products_app/presentation/widgets/product_items.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Carrito'),
      ),
      body: ListLoader(
        loadCondition: cartProvider.loadStatus == LoadStatus.founded,
        content: cartProvider.cart.isEmpty
            ? const EmptyLocalContent(
          sufixText: 'tu carrito',
          sufixTextButton: 'comprar',
          indexHomeRedirection: 1,
        ) : const _NotEmptyCart(),
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
                        final snackBar = CustomeSnackBar.getSnackBar(
                          text: 'Compra realizada con exito!',
                          backgroundColor: AppColors.green,
                          seconds: 3,
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
                          PriceProductItem(
                              price:
                                  '\$${product.product.price.toStringAsFixed(1)}'),
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
