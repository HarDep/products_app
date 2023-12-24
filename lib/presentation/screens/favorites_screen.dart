import 'package:flutter/material.dart';
import 'package:products_app/domain/models/load_status.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/presentation/providers/favorites_provider.dart';
import 'package:products_app/presentation/widgets/empty_local_content.dart';
import 'package:products_app/presentation/widgets/loading_widgets.dart';
import 'package:products_app/presentation/widgets/search_field.dart';
import 'package:products_app/presentation/widgets/grid_view_list.dart';
import 'package:products_app/presentation/widgets/product_cards.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesProvider favoritesProvider = Provider.of<FavoritesProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: favoritesProvider.favorites.isNotEmpty? 130 : 0,
        title: const Text('Mis Favoritos'),
        leading: favoritesProvider.favorites.isNotEmpty? const SearchField(
          tag: TagPage.favorites,
        ) : const SizedBox.shrink(),
      ),
      body: ListLoader(
        loadCondition: favoritesProvider.loadStatus == LoadStatus.founded,
        content: favoritesProvider.favorites.isNotEmpty? 
        GridViewList(
          title: 'Mis productos favoritos',
          conditionList: favoritesProvider.favorites.isNotEmpty,
          itemsLength: favoritesProvider.favorites.length,
          itemBuild: (context, index) {
            ProductInfo product = favoritesProvider.favorites[index];
            return VerticalProductCard(
              product: product,
              rightPadding: 0.0,
              tagPrefix: 'favt',
            );
          },
        ) : const EmptyLocalContent(
          sufixText: 'tus favoritos',
          sufixTextButton: 'ver nuestros productos',
          indexHomeRedirection: 0,
        ),
      ),
    );
  }
}
