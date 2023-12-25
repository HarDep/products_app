import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/load_status.dart';
import 'package:products_app/domain/models/product_category.dart';
import 'package:products_app/presentation/providers/principal_provider.dart';
import 'package:products_app/presentation/widgets/grid_view_list.dart';
import 'package:products_app/presentation/widgets/loading_widgets.dart';
import 'package:products_app/presentation/widgets/product_category_widgets.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Categorias de productos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Selecciona una categoria',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).cardColor),
            ),
          ),
          const Expanded(child: _CategoriesList()),
        ],
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  const _CategoriesList();

  @override
  Widget build(BuildContext context) {
    final PrincipalProvider principalProvider =
        Provider.of(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListLoader(
        loadCondition: principalProvider.loadStatus == LoadStatus.founded,
        content: principalProvider.categories.length > 1
            ? ListView.builder(
                itemCount: principalProvider.categories.length,
                itemBuilder: (_, index) {
                  final ProductCategory category =
                      principalProvider.categories[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Category(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        showCategoryName: false,
                        category: category,
                        index: index,
                        action: (catIndex) {
                          principalProvider.searchListsWithCategories(catIndex);
                          Navigator.of(context).pop();
                        },
                      ),
                      Text(
                        category.name,
                        style: const TextStyle(color: AppColors.green),
                      ),
                    ],
                  );
                },
              )
            : const NotFoundContent(),
      ),
    );
  }
}
