import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/ingredient.dart';
import 'package:products_app/domain/models/product_info.dart';
import 'package:products_app/presentation/providers/cart_provider.dart';
import 'package:products_app/presentation/providers/principal_provider.dart';
import 'package:products_app/presentation/widgets/avatar_clips.dart';
import 'package:products_app/presentation/widgets/custome_button.dart';
import 'package:products_app/presentation/widgets/custome_hero_circle_border.dart';
import 'package:products_app/presentation/widgets/custome_snack_bar.dart';
import 'package:products_app/presentation/widgets/loading_widgets.dart';
import 'package:products_app/presentation/widgets/product_cards.dart';
import 'package:provider/provider.dart';

const double radius = 50;

class ProductDetailScreen extends StatelessWidget {
  final String tag;
  const ProductDetailScreen({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final PrincipalProvider principalProvider = Provider.of<PrincipalProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          principalProvider.currentInfo!.product.name,
          style: const TextStyle(
            color: AppColors.white,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        foregroundColor: AppColors.white,
        shape: const Border(),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: (size.height / 2) - (radius / 2),
            left: 0,
            right: 0,
            child: Hero(
              tag: tag,
              child: NetworkImageWithCircularProgress(
                  image: principalProvider.currentInfo!.product.image),
            ),
          ),
          Positioned(
            top: (size.height / 2) - (radius / 2),
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(radius),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: _ItemsDetails(
                product: principalProvider.currentInfo!,
              ),
            ),
          ),
          Positioned(
            top: (size.height / 2) - (radius / 2) - radius,
            right: 0,
            left: size.width - radius,
            bottom: (size.height / 2) - (radius / 2),
            child: CustomPaint(
              painter: CustomeHeroCircleBorder(context: context, radius: radius),
            ),
          ),
          Positioned(
            right: radius,
            top: size.height / 2 - radius,
            child: CircleAvatar(
              radius: radius / 2,
              backgroundColor: principalProvider.currentInfo!.isFavorite? AppColors.pink : AppColors.lightGrey,
              child: IconButton(
                onPressed: () => setIsFavoriteProduct(principalProvider.currentInfo!, context),
                icon: const Icon(
                  Icons.favorite_border,
                  color: AppColors.white,
                  size: radius / 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemsDetails extends StatelessWidget {
  final ProductInfo product;
  const _ItemsDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    final PrincipalProvider principalProvider =
        Provider.of(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Padding(
      padding:
          const EdgeInsets.only(top: radius, left: 30, right: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Descripcion',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.green,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            product.product.description,
            style: const TextStyle(color: AppColors.lightGrey),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ingredientes',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.green,
                ),
              ),
              principalProvider.currentDetails != null
                  ? Text(
                      '${principalProvider.currentDetails!.ingredients.length} ingredientes',
                      style: const TextStyle(color: AppColors.lightGrey),
                    )
                  : const CircleAvatar(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 120,
            child: principalProvider.currentDetails != null
                ? ListView.builder(
                    itemCount:
                        principalProvider.currentDetails!.ingredients.length,
                    scrollDirection: Axis.horizontal,
                    itemExtent: 120,
                    itemBuilder: (_, index) {
                      Ingredient ingredient =
                          principalProvider.currentDetails!.ingredients[index];
                      return _Ingredient(ingredient: ingredient);
                    },
                  )
                : const ListLoading(),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomeButton(
                text: 'Ordenar ahora',
                voidCallback: () {
                  cartProvider.add(product.product);
                  final SnackBar snackBar = CustomeSnackBar.getSnackBar(
                    text: 'Producto añadido al carrito',
                    backgroundColor: AppColors.green,
                    seconds: 1,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                height: 50,
                textPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
              Text(
                '\$${product.product.price.toStringAsFixed(2)}',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: AppColors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Ingredient extends StatelessWidget {
  final Ingredient ingredient;
  const _Ingredient({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SquareAvatar(image: ingredient.image, circularRadius: 10.0),
          ),
          Text(
            ingredient.name,
            style: const TextStyle(color: AppColors.lightGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
