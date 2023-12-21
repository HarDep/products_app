import 'package:flutter/material.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/repository/api_repository.dart';
import 'package:products_app/presentation/providers/cart_provider.dart';
import 'package:products_app/presentation/providers/products_provider.dart';
import 'package:products_app/presentation/widgets/avatar_clips.dart';
import 'package:products_app/presentation/widgets/custome_button.dart';
import 'package:products_app/presentation/widgets/loading_widgets.dart';
import 'package:products_app/presentation/widgets/product_items.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
      )..loadProducts(),
      builder: (_, __) => const ProductsScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Productos'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Productos',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).cardColor),
            ),
          ),
          Expanded(
            child: productsProvider.products.isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: productsProvider.products.length,
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      Product product = productsProvider.products[index];
                      return _ItemProduct(
                        product: product,
                      );
                    },
                  )
                : const ListLoading(),
          ),
        ],
      ),
    );
  }
}

class _ItemProduct extends StatelessWidget {
  final Product product;

  const _ItemProduct({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Card(
      elevation: 5,
      surfaceTintColor: Colors.transparent,
      color: Theme.of(context).canvasColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CircleAvatar(
                child: OvalAvatar(image: product.image),
              ),
            ),
            Expanded(
                child: Column(
              children: [
                NameDescriptionsProductItems(product: product),
                PriceProductItem(price: '\$${product.price.toStringAsFixed(1)} USD', color: Theme.of(context).iconTheme.color!),
              ],
            )),
            CustomeButton(
              text: 'Agregar',
              voidCallback: () {
                cartProvider.add(product);
              },
              height: 30,
              textPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
            ),
          ],
        ),
      ),
    );
  }
}
