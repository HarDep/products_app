import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/load_status.dart';
import 'package:products_app/domain/models/product_category.dart';
import 'package:products_app/presentation/providers/principal_provider.dart';
import 'package:products_app/presentation/screens/categories_screen.dart';
import 'package:products_app/presentation/widgets/grid_view_list.dart';
import 'package:products_app/presentation/widgets/loading_widgets.dart';
import 'package:provider/provider.dart';

class CategoriesHorizontal extends StatelessWidget {
  final IndexVoidCallBack action;
  final String title;
  final bool isVisibleSeeAllButton;
  const CategoriesHorizontal(
      {super.key,
      required this.title,
      this.isVisibleSeeAllButton = true,
      required this.action});

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
              Text(
                title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.green,
                ),
              ),
              if (isVisibleSeeAllButton)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const CategoriesScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Ver todas',
                    style: TextStyle(color: AppColors.lightGrey),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListLoader(
              loadCondition: principalProvider.loadStatus == LoadStatus.founded,
              content: principalProvider.categories.length > 1
                  ? ListView.builder(
                      itemCount: principalProvider.categories.length,
                      scrollDirection: Axis.horizontal,
                      itemExtent: 100,
                      itemBuilder: (context, index) {
                        ProductCategory category =
                            principalProvider.categories[index];
                        return Category(
                          category: category,
                          index: index,
                          action: action,
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

typedef IndexVoidCallBack = void Function(int);

class Category extends StatelessWidget {
  final IndexVoidCallBack action;
  final int index;
  final ProductCategory category;
  final EdgeInsetsGeometry padding;
  final bool showCategoryName;
  const Category(
      {super.key,
      required this.category,
      required this.index,
      required this.action,
      this.padding = const EdgeInsets.only(right: 8.0),
      this.showCategoryName = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: ElevatedButton(
              onPressed: () {
                action(index);
              },
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
          if(showCategoryName) Text(
            category.name,
            style: const TextStyle(color: AppColors.green),
          ),
        ],
      ),
    );
  }
}
