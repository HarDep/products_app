import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/presentation/delegates/search_products_delegate.dart';

class SearchField extends StatelessWidget {
  final String tag; 
  const SearchField({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: FloatingActionButton.large(
        heroTag: tag,
        backgroundColor: Theme.of(context).canvasColor,
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchProductsDelegate(),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.search_outlined,
              color: AppColors.purple,
              size: 20,
            ),
            Text(
              'Buscar',
              style: TextStyle(fontSize: 15, color: AppColors.lightGrey),
            ),
          ],
        ),
      ),
    );
  }
}
