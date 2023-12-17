import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Mi Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40,bottom: 10, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.green),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 60,
                            ),
                          )),
                    ),
                    Positioned(
                      top: 105,
                      right: 0,
                      left: 0,
                      child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.white),
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircleAvatar(
                              radius: 15,
                            ),
                          )),
                    ),
                    Positioned(
                      top: 145,
                      right: 0,
                      left: 0,
                      child: Text(
                        'Carlos Perez', textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).iconTheme.color),
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Card(
                    color: Theme.of(context).canvasColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Informacion Personal',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Correo',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: AppColors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            'coreo@dominio.ext',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color,
                                fontSize: 15),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SwitchListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                              value: false,
                              title: Text(
                                'Modo Oscuro',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Theme.of(context).cardColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              onChanged: (value) {}),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                      child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(AppColors.purple)),
                    onPressed: () {},
                    child: const Text(
                      'Cerrar Sesion',
                      style: TextStyle(color: AppColors.white),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
