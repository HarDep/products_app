import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';

class CustomeSnackBar {

  static SnackBar getSnackBar({
    required String text,
    Color textColor = AppColors.white,
    Color backgroundColor = AppColors.pink,
    int seconds = 2,
  }){
    return SnackBar(
      content: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
      duration: Duration(seconds: seconds),
      backgroundColor: backgroundColor,
    );
  }

}

