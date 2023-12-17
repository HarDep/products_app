import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';

final OutlineInputBorder _borderLight = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: AppColors.veryLightGrey,
    width: 2,
    style: BorderStyle.solid,
  )
);

final lightTheme = ThemeData(
  cardColor: AppColors.purple,
  appBarTheme: const AppBarTheme(
    color: AppColors.white,
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: AppColors.purple),
    centerTitle: true,
    shape: Border(
      bottom: BorderSide(
        color: AppColors.veryLightGrey,
        width: 2,
      ),
    ),
  ),
  canvasColor: AppColors.veryLightGrey,
  scaffoldBackgroundColor: AppColors.white,
  inputDecorationTheme: InputDecorationTheme(
      border: _borderLight,
      hintStyle: const TextStyle(color: AppColors.purple, fontSize: 15),
      enabledBorder: _borderLight,
      focusedBorder: _borderLight,
      fillColor: AppColors.white,
      filled: true,
    ),
  iconTheme: const IconThemeData(
    color: AppColors.purple
  )
);

final OutlineInputBorder _borderDark = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: AppColors.grey,
    width: 2,
    style: BorderStyle.solid,
  )
);

final darkTheme = ThemeData(
  cardColor: AppColors.green,
  appBarTheme: const AppBarTheme(
    color: AppColors.purple,
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: AppColors.white),
    centerTitle: true,
  ),
  canvasColor: AppColors.grey,
  scaffoldBackgroundColor: AppColors.dark,
  inputDecorationTheme: InputDecorationTheme(
      border: _borderLight,
      hintStyle: const TextStyle(color: AppColors.white, fontSize: 15),
      enabledBorder: _borderDark,
      focusedBorder: _borderDark,
      fillColor: AppColors.grey,
      filled: true,
    ),
  iconTheme: const IconThemeData(
    color: AppColors.white
  )
);
