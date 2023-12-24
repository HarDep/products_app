import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';

class OvalAvatar extends StatelessWidget {
  final String image;
  const OvalAvatar({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: NetworkImageWithCircularProgress(image: image),
    );
  }
}

class SquareAvatar extends StatelessWidget {
  final String image;
  final double circularRadius;
  const SquareAvatar(
      {super.key, required this.image, required this.circularRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circularRadius),
      child: NetworkImageWithCircularProgress(image: image),
    );
  }
}

class NetworkImageWithCircularProgress extends StatelessWidget {
  final String image;
  const NetworkImageWithCircularProgress({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: BoxFit.cover,
      errorBuilder: (context, object, stackTrace) {
        return const Center(
          child: FittedBox(
            child: Text('No se pudo cargar la imagen',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.pink),
            ),
          ),
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
