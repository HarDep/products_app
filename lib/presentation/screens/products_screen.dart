import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/load_status.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/presentation/providers/cart_provider.dart';
import 'package:products_app/presentation/providers/products_provider.dart';
import 'package:products_app/presentation/widgets/custome_snack_bar.dart';
import 'package:products_app/presentation/widgets/loading_widgets.dart';
import 'package:products_app/presentation/widgets/search_field.dart';
import 'package:products_app/presentation/widgets/avatar_clips.dart';
import 'package:products_app/presentation/widgets/custome_button.dart';
import 'package:products_app/presentation/widgets/grid_view_list.dart';
import 'package:products_app/presentation/widgets/product_items.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  // const ProductsScreen._();

  

  /* static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
      )..loadProducts(),
      builder: (_, __) => const ProductsScreen._(),
    );
  } */

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 130,
        title: const Text('Productos'),
        leading: const SearchField(tag: TagPage.products,),
      ),
      body: ListLoader(
        loadCondition: productsProvider.loadStatus == LoadStatus.founded,
        content: GridViewList(
          title: 'Productos', 
          conditionList: productsProvider.products.isNotEmpty, 
          itemsLength: productsProvider.products.length, 
          itemBuild: (context, index) {
            Product product = productsProvider.products[index];
            return ItemProduct(
              product: product,
            );
          },
        ),
      ),
    );
  }
}

class ItemProduct extends StatelessWidget {
  final Product product;

  const ItemProduct({ super.key, required this.product});

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
                final SnackBar snackBar = CustomeSnackBar.getSnackBar(
                  text: 'Producto añadido al carrito',
                  backgroundColor: AppColors.green,
                  seconds: 1,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
