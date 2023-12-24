import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';

class EmptyLocalContent extends StatelessWidget {
  final String sufixText;
  final String sufixTextButton;
  final int indexHomeRedirection;

  const EmptyLocalContent(
      {super.key, required this.sufixText, required this.sufixTextButton, required this.indexHomeRedirection});
      
  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/sad.png',
          color: AppColors.green,
          height: 120,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'No hay productos en $sufixText',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Center(
            child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.purple)),
          onPressed: () {
            homeProvider.updateIndex(indexHomeRedirection);
          },
          child: Text(
            'Ir a $sufixTextButton',
            style: const TextStyle(color: AppColors.white),
          ),
        )),
      ],
    );
  }
}
