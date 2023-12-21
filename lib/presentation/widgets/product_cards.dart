import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/data/memory_products.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/models/product_details.dart';
import 'package:products_app/presentation/screens/product_details_screen.dart';
import 'package:products_app/presentation/widgets/avatar_clips.dart';
import 'package:products_app/presentation/widgets/product_items.dart';

class VerticalProductCard extends StatelessWidget {
  final Product product;
  final double rightPadding;

  const VerticalProductCard(
      {super.key, required this.product, required this.rightPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: rightPadding),
      child: Stack(
        children: [
          Card(
            surfaceTintColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            color: Theme.of(context).canvasColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Hero(
                      tag: 'vert${product.name}',
                      child: CircleAvatar(
                        child: OvalAvatar(image: product.image),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      NameDescriptionsProductItems(
                        product: product,
                        textsAlign: TextAlign.start,
                        nameMaxLines: 1,
                        descriptionMaxLines: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      PriceHeroProductItems(product: product, isVerical: true,),
                    ],
                  )),
                ],
              ),
            ),
          ),
          const FavoriteIcon(),
        ],
      ),
    );
  }
}

class HorizontalProductCard extends StatelessWidget {
  final Product product;
  final double rightPadding;

  const HorizontalProductCard(
      {super.key, required this.product, required this.rightPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: rightPadding),
      child: Stack(
        children: [
          Card(
            surfaceTintColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            color: Theme.of(context).canvasColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'hor${product.name}',
                      child: SquareAvatar(
                          image: product.image, circularRadius: 10.0),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      NameDescriptionsProductItems(
                        product: product,
                        textsAlign: TextAlign.start,
                        nameMaxLines: 2,
                        descriptionMaxLines: 3,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      PriceHeroProductItems(product: product, isVerical: false,),
                    ],
                  )),
                ],
              ),
            ),
          ),
          const FavoriteIcon(),
        ],
      ),
    );
  }
}

class PriceHeroProductItems extends StatelessWidget {
  final Product product;
  final bool isVerical;
  const PriceHeroProductItems({super.key, required this.product, required this.isVerical});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PriceProductItem(
          price: '\$${product.price.toStringAsFixed(1)}',
        ),
        IconButton(
          onPressed: () {
            ProductDetails details = productDetails
                .firstWhere((elm) => elm.product.name == product.name);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ProductDetailScreen(productDetails: details, isVertical: isVerical)));
          },
          icon: const Icon(
            Icons.chevron_right_outlined,
            color: AppColors.green,
          ),
        ),
      ],
    );
  }
}

//debe estar en un stack
class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 2,
      top: 2,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.favorite_border_outlined,
          color: AppColors.pink,
        ),
      ),
    );
  }
}
