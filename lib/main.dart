import 'package:flutter/material.dart';
import 'package:products_app/data/datasource/api_rep_impl.dart';
import 'package:products_app/data/datasource/local_rep_impl.dart';
import 'package:products_app/presentation/providers/cart_provider.dart';
import 'package:products_app/presentation/providers/favorites_provider.dart';
import 'package:products_app/presentation/providers/login_provider.dart';
import 'package:products_app/presentation/providers/principal_provider.dart';
import 'package:products_app/presentation/providers/products_provider.dart';
import 'package:products_app/presentation/providers/splash_provider.dart';
import 'package:products_app/presentation/providers/theme_provider.dart';
import 'package:products_app/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'domain/repository/repositories.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiRepositoryInterface>(create: (_) => ApiReppositoryImpl(),),
        Provider<LocalRepositoryInterface>(create: (_) => LocalRepositoryImpl(),),
        ChangeNotifierProvider(create: (context) {
          return ThemeProvider(
            localRepositoryInterface: context.read<LocalRepositoryInterface>(),
          )..loadTheme();
        }),
        ChangeNotifierProvider(create: (context) {
          return SplashProvider(
            localRepositoryInterface: context.read<LocalRepositoryInterface>(),
            apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
          );
        }),
        ChangeNotifierProvider(create: (context) {
          return LoginProvider(
            localRepositoryInterface: context.read<LocalRepositoryInterface>(),
            apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
          );
        }),
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(
            apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
          )..loadProducts(),
        ),
        ChangeNotifierProvider(create: (context) => CartProvider(
            localRepositoryInterface: context.read<LocalRepositoryInterface>(),
            apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
          )..loadCart(),
        ),
        ChangeNotifierProvider(create: (context) => PrincipalProvider(
            localRepositoryInterface: context.read<LocalRepositoryInterface>(),
            apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
          )..loadLists(),
        ),
        ChangeNotifierProvider(create: (context) => FavoritesProvider(
            localRepositoryInterface: context.read<LocalRepositoryInterface>(),
          )..loadFavorites(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Products App',
            home: const SplashScreen(),
            theme: themeProvider.currentTheme,
          );
        }
      ),
    );
  }
}
