import 'package:flutter/material.dart';
import 'package:products_app/configs/themes.dart';
import 'package:products_app/presentation/screens/splash_screen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products App',
      home: const SplashScreen(),
      theme: darkTheme,
    );
  }
}