import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/presentation/providers/favorites_provider.dart';
import 'package:products_app/presentation/providers/home_provider.dart';
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
      body: favoritesProvider.favorites.isNotEmpty? GridViewList(
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
      ) : const _EmptyFavorites(),
    );
  }
}


class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();
  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
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
          'No hay productos en tus favoritos',
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
          onPressed: () {
            homeProvider.updateIndex(0);
          },
          child: const Text(
            'Ir a ver nuestros productos',
            style: TextStyle(color: AppColors.white),
          ),
        )),
      ],
    );
  }
}
