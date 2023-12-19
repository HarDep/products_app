import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/presentation/providers/splash_provider.dart';
import 'package:products_app/presentation/screens/home_screen.dart';
import 'package:products_app/presentation/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _validateSession();
      },
    );
    super.initState();
  }

  void _validateSession() async {
    final SplashProvider splashProvider = context.read<SplashProvider>();
    bool validation = await splashProvider.validateSesion();
    if (validation) {
      _navigate(_getHomeScreen());
      return;
    }
    _navigate(const LoginScreen());
  }

  Widget _getHomeScreen() {
    return HomeScreen.init(context);
  }

  void _navigate(Widget screen) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.appGradient,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 77,
              child: Image.asset('assets/img.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Products App',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
