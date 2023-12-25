import 'dart:async';

import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/presentation/providers/favorites_provider.dart';
import 'package:products_app/presentation/providers/principal_provider.dart';
import 'package:products_app/presentation/providers/products_provider.dart';
import 'package:products_app/presentation/screens/products_screen.dart';
import 'package:products_app/presentation/widgets/grid_view_list.dart';
import 'package:products_app/presentation/widgets/loading_widgets.dart';
import 'package:products_app/presentation/widgets/product_cards.dart';
import 'package:products_app/presentation/widgets/product_category_widgets.dart';
import 'package:products_app/presentation/widgets/search_field.dart';
import 'package:provider/provider.dart';

class SearchProductsDelegate extends SearchDelegate<Product> {
  final TagPage tagPage;
  int categoryIndex = 0;
  final int millisecondsLoadDelay = 500;

  SearchProductsDelegate({required this.tagPage});

  @override
  String get searchFieldLabel => 'Busca los productos';

  @override
  TextStyle get searchFieldStyle => const TextStyle(
        color: AppColors.lightGrey,
        fontWeight: FontWeight.bold,
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      canvasColor: Theme.of(context).canvasColor,
      iconTheme: IconThemeData(
        color: Theme.of(context).iconTheme.color!,
      ),
      cardColor: Theme.of(context).cardColor,
      appBarTheme: Theme.of(context).appBarTheme,
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      hintColor: AppColors.lightGrey,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Theme.of(context).canvasColor,
        contentPadding: const EdgeInsets.all(10.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(
          Icons.clear,
          color: AppColors.pink,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: AppColors.pink,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    switch (tagPage) {
      case TagPage.principal:
        return _getPrincipalContent(context, true);
      case TagPage.favorites:
        return _getFavoritesContent(context, true);
      case TagPage.products:
        return _getProductsContent(context, true);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    switch (tagPage) {
      case TagPage.principal:
        return _getPrincipalContent(context, false);
      case TagPage.favorites:
        return _getFavoritesContent(context, false);
      case TagPage.products:
        return _getProductsContent(context, false);
    }
  }

  Widget _getPrincipalContent(BuildContext context, bool isBuildResults) {
    final PrincipalProvider principalProvider =
        Provider.of<PrincipalProvider>(context, listen: false);
    if (isBuildResults) {
      principalProvider.cancelDebouncerTimer();
      principalProvider.searchProductsQuery(query, categoryIndex);
    } else {
      principalProvider.rebootDebouncerTimer(query, categoryIndex);
      principalProvider.showLoadQuery();
    }
    return Column(
      children: [
        CategoriesHorizontal(
          title: 'Selecciona una categoria',
          isVisibleSeeAllButton: false,
          action: (index) {
            principalProvider.showLoadQuery();
            categoryIndex = index;
            principalProvider.searchProductsQuery(
                query, index, millisecondsLoadDelay);
          },
        ),
        _StreamConstructor<ProductInfo>(
          isChild: true,
          stream: principalProvider.resultsStream,
          listTitle: 'Resultados de productos',
          itemBuilding: (_, item) {
            return VerticalProductCard(
              product: item,
              rightPadding: 0.0,
              tagPrefix: '$tagPage search: $query ',
              anotherAction: () {
                principalProvider.searchProductsQuery(query, categoryIndex);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _getFavoritesContent(BuildContext context, bool isBuildResults) {
    final FavoritesProvider favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    if (isBuildResults) {
      favoritesProvider.cancelDebouncerTimer();
      favoritesProvider.searchFavoriteQuery(query);
    } else {
      favoritesProvider.rebootDebouncerTimer(query);
      favoritesProvider.showLoadQuery();
    }
    return _StreamConstructor<ProductInfo>(
      isChild: false,
      stream: favoritesProvider.resultsStream,
      listTitle: 'Resultados de favoritos',
      itemBuilding: (_, item) {
        return VerticalProductCard(
          product: item,
          rightPadding: 0.0,
          tagPrefix: '$tagPage search: $query ',
          anotherAction: () {
            favoritesProvider.searchFavoriteQuery(query);
          },
        );
      },
    );
  }

  Widget _getProductsContent(BuildContext context, bool isBuildResults) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    if (isBuildResults) {
      productsProvider.cancelDebouncerTimer();
      productsProvider.searchProductsQuery(query);
    } else {
      productsProvider.rebootDebouncerTimer(query);
      productsProvider.showLoadQuery();
    }
    return _StreamConstructor<Product>(
      isChild: false,
      stream: productsProvider.resultsStream,
      listTitle: 'Resultados de productos',
      itemBuilding: (_, item) {
        return ItemProduct(
          product: item,
        );
      },
    );
  }
}

typedef ItemBuilding<T> = Widget Function(BuildContext, T);

class _StreamConstructor<T> extends StatelessWidget {
  final Stream<List<T>?> stream;
  final ItemBuilding<T> itemBuilding;
  final String listTitle;
  final bool isChild;
  const _StreamConstructor(
      {required this.stream,
      required this.itemBuilding,
      required this.listTitle,
      required this.isChild});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<List<T>?> snapshot) {
        //print(snapshot.data);
        if (snapshot.data == null) {
          return const ListLoading();
        }
        final List<T> list = snapshot.data!;
        return list.isNotEmpty
            ? isChild
                ? GridViewListAsChild(
                    title: listTitle,
                    conditionList: list.isNotEmpty,
                    itemsLength: list.length,
                    itemBuild: (context, index) {
                      final T item = list[index];
                      return itemBuilding(context, item);
                    },
                  )
                : GridViewList(
                    title: listTitle,
                    conditionList: list.isNotEmpty,
                    itemsLength: list.length,
                    itemBuild: (context, index) {
                      final T item = list[index];
                      return itemBuilding(context, item);
                    },
                  )
            : const NotFoundContent();
      },
    );
  }
}
