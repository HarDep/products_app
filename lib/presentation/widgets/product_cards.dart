import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/presentation/providers/favorites_provider.dart';
import 'package:products_app/presentation/providers/principal_provider.dart';
import 'package:products_app/presentation/screens/product_details_screen.dart';
import 'package:products_app/presentation/widgets/avatar_clips.dart';
import 'package:products_app/presentation/widgets/product_items.dart';
import 'package:provider/provider.dart';

class VerticalProductCard extends StatelessWidget {
  final ProductInfo product;
  final double rightPadding;
  final String tagPrefix;
  final VoidCallback? anotherAction;

  const VerticalProductCard(
      {super.key,
      required this.product,
      required this.rightPadding,
      required this.tagPrefix,
      this.anotherAction});

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
                      tag: '$tagPrefix${product.product.name}',
                      child: CircleAvatar(
                        child: OvalAvatar(image: product.product.image),
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
                        product: product.product,
                        textsAlign: TextAlign.start,
                        nameMaxLines: 1,
                        descriptionMaxLines: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      PriceHeroProductItems(
                        product: product,
                        heroTag: '$tagPrefix${product.product.name}',
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          FavoriteIconPositioned(
            product: product,
            anotherAction: anotherAction,
          ),
        ],
      ),
    );
  }
}

class HorizontalProductCard extends StatelessWidget {
  final ProductInfo product;
  final double rightPadding;
  final String tagPrefix;

  const HorizontalProductCard(
      {super.key,
      required this.product,
      required this.rightPadding,
      required this.tagPrefix});

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
                      tag: '$tagPrefix${product.product.name}',
                      child: SquareAvatar(
                          image: product.product.image, circularRadius: 10.0),
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
                        product: product.product,
                        textsAlign: TextAlign.start,
                        nameMaxLines: 2,
                        descriptionMaxLines: 3,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      PriceHeroProductItems(
                        product: product,
                        heroTag: '$tagPrefix${product.product.name}',
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          FavoriteIconPositioned(
            product: product,
          ),
        ],
      ),
    );
  }
}

class PriceHeroProductItems extends StatelessWidget {
  final ProductInfo product;
  final String heroTag;
  const PriceHeroProductItems(
      {super.key, required this.product, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PriceProductItem(
          price: '\$${product.product.price.toStringAsFixed(1)}',
        ),
        IconButton(
          onPressed: () {
            final PrincipalProvider principalProvider =
                context.read<PrincipalProvider>();
            principalProvider.setCurrentHeroProduct(product);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(
                  tag: heroTag,
                ),
              ),
            );
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
class FavoriteIconPositioned extends StatelessWidget {
  final VoidCallback? anotherAction;
  final ProductInfo product;
  const FavoriteIconPositioned({super.key, required this.product, this.anotherAction});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 2,
      top: 2,
      child: IconButton(
      onPressed: () {
        setIsFavoriteProduct(product, context);
        if(anotherAction != null){
          anotherAction!();
        }
      },
      icon: Icon(
        product.isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
        color: AppColors.pink,
      ),
    ),
    );
  }
}

void setIsFavoriteProduct(ProductInfo product, BuildContext context) {
  product.isFavorite = !product.isFavorite;
  final PrincipalProvider principalProvider = context.read<PrincipalProvider>();
  principalProvider.setFavoriteProduct(product);
  final FavoritesProvider favoritesProvider = context.read<FavoritesProvider>();
  favoritesProvider.setFavoriteProduct(product);
}
