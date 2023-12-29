import 'package:flutter/material.dart';

class CustomeHeroCircleBorder extends CustomPainter {
  final double radius;
  final BuildContext context;

  CustomeHeroCircleBorder({
    super.repaint,
    required this.context,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Theme.of(context).scaffoldBackgroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, radius);
    path.arcToPoint(Offset(size.width, 0), radius: Radius.circular(radius), clockwise: false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
