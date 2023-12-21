import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/product.dart';

class NameDescriptionsProductItems extends StatelessWidget {
  final Product product;
  final TextAlign textsAlign;
  final int nameMaxLines;
  final int descriptionMaxLines;

  const NameDescriptionsProductItems({
    super.key,
    required this.product,
    this.textsAlign = TextAlign.center,
    this.nameMaxLines = 2,
    this.descriptionMaxLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          product.name,
          maxLines: nameMaxLines,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).cardColor,
              fontWeight: FontWeight.bold),
          textAlign: textsAlign,
        ),
        Text(
          product.description,
          maxLines: descriptionMaxLines,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, color: AppColors.lightGrey),
          textAlign: textsAlign,
        ),
      ],
    );
  }
}

class PriceProductItem extends StatelessWidget {
  final String price;
  final Color color;
  const PriceProductItem({super.key, required this.price, this.color = AppColors.green});

  @override
  Widget build(BuildContext context) {
    return Text(
      price,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 13, color: color, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}
