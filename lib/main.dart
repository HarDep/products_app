import 'package:flutter/material.dart';
import 'package:products_app/configs/themes.dart';
import 'package:products_app/data/datasource/api_rep_impl.dart';
import 'package:products_app/data/datasource/local_rep_impl.dart';
import 'package:products_app/domain/repository/api_repository.dart';
import 'package:products_app/domain/repository/local_storage_repository.dart';
import 'package:products_app/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiRepositoryInterface>(create: (_) => ApiReppositoryImpl()),
        Provider<LocalRepositoryInterface>(create: (_) => LocalRepositoryImpl()),
      ],
      child: Builder(
        builder: (newContext) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Products App',
            home: SplashScreen.init(newContext),
            theme: darkTheme,
          );
        }
      ),
    );
  }
}