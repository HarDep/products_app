import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/presentation/providers/login_provider.dart';
import 'package:products_app/presentation/screens/home_screen.dart';
import 'package:products_app/presentation/widgets/custome_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void doLogin(BuildContext context) async {
    final provider = context.read<LoginProvider>();
    final loginResult = await provider.login();
    if (loginResult) {
      provider.usernameTextController.text = '';
      provider.passwordTextController.text = '';
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen.init(context)));
      return;
    }
    final snackBar = SnackBar(
      content: const Text('Usuario y/o contraseña incorrectos!'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
      duration: const Duration(seconds: 2),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: true);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 50,
                        left: -25,
                        right: -25,
                        height: size.width + 50,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: AppColors.appGradient,
                              stops: [0.5, 1.0],
                            ),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(size.width / 2)),
                          ),
                        )),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).canvasColor,
                          radius: 50,
                          child: Image.asset(
                            'assets/img.png',
                          ),
                        ))
                  ],
                ),
              ),
              Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Iniciar Sesion',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Theme.of(context).iconTheme.color),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            'Username',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color,
                                fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            controller: loginProvider.usernameTextController,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              prefixIcon: Icon(
                                Icons.person_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Password',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color,
                                fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            obscureText: true,
                            controller: loginProvider.passwordTextController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(
                                Icons.password_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CustomeButton(
                  height: 50,
                  text: 'iniciar sesion',
                  voidCallback: () => doLogin(context),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
          Positioned.fill(
            child: loginProvider.loginState == LoginState.loading
                ? Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
