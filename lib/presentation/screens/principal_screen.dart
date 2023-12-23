import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/product_category.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/presentation/providers/principal_provider.dart';
import 'package:products_app/presentation/widgets/search_field.dart';
import 'package:products_app/presentation/widgets/loading_widgets.dart';
import 'package:products_app/presentation/widgets/product_cards.dart';
import 'package:provider/provider.dart';

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PrincipalProvider principalProvider =
        Provider.of(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 130,
        title: const Text('Inicio'),
        leading: const SearchField(
          tag: TagPage.principal,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: AppColors.pink,
              ),
              onPressed: () {
                // Acción a realizar cuando se presiona el botón
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Categories(),
            _SectionProducts(
              productsList: principalProvider.famous,
              title: 'Productos populares',
              isVericalCart: true,
              cartHeight: 250,
              itemExtent: 170,
            ),
            _SectionProducts(
              productsList: principalProvider.recommended,
              title: 'Recomendados',
              isVericalCart: false,
              cartHeight: 170,
              itemExtent: 270,
            ),
          ],
        ),
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories();

  @override
  Widget build(BuildContext context) {
    final PrincipalProvider principalProvider =
        Provider.of(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Explorar categorias',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.green,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Ver todas',
                  style: TextStyle(color: AppColors.lightGrey),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            child: principalProvider.categories.length > 1
                ? ListView.builder(
                    itemCount: principalProvider.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemExtent: 100,
                    itemBuilder: (context, index) {
                      ProductCategory category =
                          principalProvider.categories[index];
                      return _Category(
                        category: category,
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

class _Category extends StatelessWidget {
  final ProductCategory category;
  const _Category({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Theme.of(context).canvasColor,
              ),
              child: Image.asset(
                category.image,
              ),
            ),
          ),
          Text(
            category.name,
            style: const TextStyle(color: AppColors.green),
          ),
        ],
      ),
    );
  }
}

class _SectionProducts extends StatelessWidget {
  final List<ProductInfo> productsList;
  final bool isVericalCart;
  final String title; //titulo debe ser unico
  final double cartHeight;
  final double itemExtent;
  const _SectionProducts({
    required this.productsList,
    required this.title,
    required this.isVericalCart,
    required this.cartHeight,
    required this.itemExtent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.green,
            ),
          ),
          SizedBox(
            height: cartHeight,
            child: productsList.isNotEmpty
                ? ListView.builder(
                    itemCount: productsList.length,
                    scrollDirection: Axis.horizontal,
                    itemExtent: itemExtent,
                    itemBuilder: (context, index) {
                      ProductInfo product = productsList[index];
                      return isVericalCart
                          ? VerticalProductCard(
                              product: product,
                              rightPadding: 8.0,
                              tagPrefix: title,
                            )
                          : HorizontalProductCard(
                              product: product,
                              rightPadding: 8.0,
                              tagPrefix: title,
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
