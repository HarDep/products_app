import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/data/memory_products.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/presentation/widgets/custome_button.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Inicio'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Productos', textAlign: TextAlign.start, 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).cardColor),
            ),
          ),
          Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                  itemCount: products.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2/3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    Product product = products[index];
                    return _ItemProduct(
                      product: product,
                    );
                  })),
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
              child: CircleAvatar(child: ClipOval(child: Image.network(product.image, fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                    ),
                  );
                },
              ))),
            ),
            Expanded(child: Column(
              children: [
                Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, 
                  style: TextStyle(fontSize: 13, color: Theme.of(context).cardColor, fontWeight: FontWeight.bold), 
                  textAlign: TextAlign.center,
                ),
                Text(product.description, maxLines: 3, overflow: TextOverflow.ellipsis, 
                  style: const TextStyle(fontSize: 10, color: AppColors.lightGrey), textAlign: TextAlign.center,
                ),
                Text('\$${product.price} USD', maxLines: 1, overflow: TextOverflow.ellipsis, 
                  style: TextStyle(fontSize: 13, color: Theme.of(context).iconTheme.color, fontWeight: FontWeight.bold), 
                  textAlign: TextAlign.center,
                ),
              ],
            )),
            CustomeButton(text: 'Agregar', voidCallback: () {}, height: 30, 
              textPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
            ),
          ],
        ),
      ),
    );
  }
}
