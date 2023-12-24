import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/load_status.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/presentation/providers/principal_provider.dart';
import 'package:products_app/presentation/widgets/grid_view_list.dart';
import 'package:products_app/presentation/widgets/product_category_widgets.dart';
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
            CategoriesHorizontal(
              title: 'Explorar categorias',
              isVisibleSeeAllButton: true,
              action: (index) {
                principalProvider.searchListsWithCategories(index);
              },
            ),
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
    final PrincipalProvider principalProvider =
        Provider.of(context, listen: true);
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
            child: ListLoader(
              loadCondition: principalProvider.loadStatus == LoadStatus.founded,
              content: productsList.isNotEmpty
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
                : const NotFoundContent(),
            ),
          ),
        ],
      ),
    );
  }
}
