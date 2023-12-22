import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/domain/models/ingredient.dart';
import 'package:products_app/domain/models/product_details.dart';
import 'package:products_app/presentation/widgets/avatar_clips.dart';
import 'package:products_app/presentation/widgets/custome_button.dart';

const double radius = 50;

class ProductDetailScreen extends StatelessWidget {
  final ProductDetails productDetails;
  final String tag;
  const ProductDetailScreen({
    super.key,
    required this.productDetails,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          productDetails.product.name,
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
          /* Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: size.width - radius,
            child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ), */
          Positioned(
            top: 0,
            bottom: (size.height / 2) - (radius / 2),
            left: 0,
            right: 0,
            child: Hero(
              tag:
                  tag,
              child: NetworkImageWithCircularProgress(
                  image: productDetails.product.image),
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
                productDetails: productDetails,
              ),
            ),
          ),
          Positioned(
            right: radius,
            top: size.height / 2 - radius,
            child: CircleAvatar(
              radius: radius / 2,
              backgroundColor: AppColors.pink,
              child: IconButton(
                onPressed: () {},
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
  final ProductDetails productDetails;
  const _ItemsDetails({required this.productDetails});

  @override
  Widget build(BuildContext context) {
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
            productDetails.product.description,
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
              Text(
                '${productDetails.ingredients.length} ingredientes',
                style: const TextStyle(color: AppColors.lightGrey),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: productDetails.ingredients.length,
              scrollDirection: Axis.horizontal,
              itemExtent: 120,
              itemBuilder: (_, index) {
                Ingredient ingredient = productDetails.ingredients[index];
                return _Ingredient(ingredient: ingredient);
              },
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomeButton(
                text: 'Ordenar ahora',
                voidCallback: () {},
                height: 50,
                textPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
              Text(
                '\$${productDetails.product.price.toStringAsFixed(2)}',
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
