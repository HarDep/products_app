import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';

class CustomeButton extends StatelessWidget {
  final String text;
  final VoidCallback voidCallback;
  final double height;
  final EdgeInsets textPadding;

  const CustomeButton(
      {super.key,
      required this.text,
      required this.voidCallback,
      required this.height,
      this.textPadding = const EdgeInsets.all(15.0)});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: voidCallback,
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: AppColors.appGradient,
          ),
        ),
        child: Padding(
          padding:  textPadding,
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
