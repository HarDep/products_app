import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/presentation/screens/cart_screen.dart';
import 'package:products_app/presentation/screens/products_screen.dart';
import 'package:products_app/presentation/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(),
        toolbarHeight: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: IndexedStack(
            index: currentIndex,
            children: [
              const ProductsScreen(),
              Text(
                'current index 2 $currentIndex',
                style: const TextStyle(color: Colors.red),
              ),
              CartScreen(
                goShopping: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
              ),
              Text(
                'current index 4 $currentIndex',
                style: const TextStyle(color: Colors.red),
              ),
              const ProfileScreen(),
            ],
          )),
          _NavigationBar(
              index: currentIndex,
              onIndexSelected: (index) {
                setState(() {
                  currentIndex = index;
                });
              }),
        ],
      )),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexSelected;

  const _NavigationBar(
      {Key? key, required this.index, required this.onIndexSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () => onIndexSelected(0),
                  icon: Icon(
                      color: index == 0 ? AppColors.green : AppColors.lightGrey,
                      Icons.home_outlined)),
              IconButton(
                  onPressed: () => onIndexSelected(1),
                  icon: Icon(
                      color: index == 1 ? AppColors.green : AppColors.lightGrey,
                      Icons.store_outlined)),
              CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.purple,
                  child: IconButton(
                      onPressed: () => onIndexSelected(2),
                      icon: Icon(
                          color: index == 2 ? AppColors.green : AppColors.white,
                          Icons.shopping_basket_outlined))),
              IconButton(
                  onPressed: () => onIndexSelected(3),
                  icon: Icon(
                      color: index == 3 ? AppColors.green : AppColors.lightGrey,
                      Icons.favorite_border_outlined)),
              InkWell(
                onTap: () => onIndexSelected(4),
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
