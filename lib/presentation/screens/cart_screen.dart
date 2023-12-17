import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/data/memory_products.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/presentation/widgets/custome_button.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback goShopping;
  const CartScreen({super.key, required this.goShopping});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Carrito'),
      ),
      body: const _NotEmptyCart(),
      /* _EmptyCart(action: goShopping,), */
    );
  }
}

class _NotEmptyCart extends StatelessWidget {
  const _NotEmptyCart();

  @override
  Widget build(BuildContext context) {
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
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              itemExtent: 250,
              itemBuilder: (context, index) {
                Product product = products[index];
                return _ShoppingProduct(product: product);
              },
            )),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).canvasColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                            Text('SubTotal:', style: TextStyle(color: Theme.of(context).iconTheme.color),), 
                            Text('\$85.00 usd', style: TextStyle(color: Theme.of(context).iconTheme.color),)],),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                            Text('Envio:', style: TextStyle(color: Theme.of(context).iconTheme.color),), 
                            Text('Gratis', style: TextStyle(color: Theme.of(context).iconTheme.color),)],),
                          const SizedBox(height: 15,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                            Text('Total:', style: TextStyle(color: Theme.of(context).iconTheme.color, fontSize: 20, fontWeight: FontWeight.bold),), 
                            Text('\$85.00 usd', style: TextStyle(color: Theme.of(context).iconTheme.color, fontSize: 20, fontWeight: FontWeight.bold),)],)
                        ],
                      ),
                      )
                    ),
                    CustomeButton(
                      textPadding: const EdgeInsets.symmetric(vertical: 17),
                      height: 55,
                        text: 'Realizar Compra',
                        voidCallback: () {}
                    ),
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
  final Product product;

  const _ShoppingProduct({required this.product});

  @override
  Widget build(BuildContext context) {
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
                        child: ClipOval(
                            child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).cardColor,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        product.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.lightGrey),
                        textAlign: TextAlign.center,
                      ),
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
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.remove,
                                    color: AppColors.purple,
                                  ))),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '1',
                              style: TextStyle(
                                  color: AppColors.lightGrey, fontSize: 17),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColors.purple,
                                  borderRadius: BorderRadius.circular(5)),
                              child: InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                  ))),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '\$${product.price}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.green,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
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
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outlined)),
          )),
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
