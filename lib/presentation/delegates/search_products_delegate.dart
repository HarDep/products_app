import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/product.dart';

class SearchProductsDelegate extends SearchDelegate<Product> {
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
    return const Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('suggestions');
  }
}
