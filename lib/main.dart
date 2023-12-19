import 'package:flutter/material.dart';
import 'package:products_app/configs/themes.dart';
import 'package:products_app/data/datasource/api_rep_impl.dart';
import 'package:products_app/data/datasource/local_rep_impl.dart';
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
        Provider<ApiRepositoryInterface>(create: (_) => ApiReppositoryImpl()),
        Provider<LocalRepositoryInterface>(
            create: (_) => LocalRepositoryImpl()),
        ChangeNotifierProvider(create: (context) {
          return ThemeProvider(
              localRepositoryInterface: context.read<LocalRepositoryInterface>(),
          )..loadTheme();
        })
      ],
      child: Builder(builder: (newContext) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider,_) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Products App',
              home: SplashScreen.init(newContext),
              theme: themeProvider.currentTheme,
            );
          }
        );
      }),
    );
  }
}
