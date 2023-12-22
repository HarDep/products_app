import 'package:flutter/material.dart';
import 'package:products_app/data/memory_products.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/presentation/screens/search_field.dart';
import 'package:products_app/presentation/widgets/grid_view_list.dart';
import 'package:products_app/presentation/widgets/product_cards.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 130,
        title: const Text('Mis Favoritos'),
        leading: const SearchField(tag: 'favorites',),
      ),
      body: GridViewList(
        title: 'Mis productos favoritos', 
        conditionList: products.isNotEmpty,
        itemsLength: products.length, 
        itemBuild: (context, index) {
          Product product = products[index];
          return VerticalProductCard(product: product, rightPadding: 0.0, tagPrefix: 'favt',);
        },
      ),
    );
  }
}