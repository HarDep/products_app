import 'package:flutter/material.dart';
import 'package:products_app/configs/colors.dart';
import 'package:products_app/presentation/providers/cart_provider.dart';
import 'package:products_app/presentation/providers/home_provider.dart';
import 'package:products_app/presentation/screens/cart_screen.dart';
import 'package:products_app/presentation/screens/favorites_screen.dart';
import 'package:products_app/presentation/screens/principal_screen.dart';
import 'package:products_app/presentation/screens/products_screen.dart';
import 'package:products_app/presentation/screens/profile_screen.dart';
import 'package:products_app/presentation/widgets/loading_widgets.dart';
import 'package:provider/provider.dart';

import '../../domain/repository/repositories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(
        localRepositoryInterface: context.read<LocalRepositoryInterface>(),
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
      )
        ..loadUser()
        ..loadTheme(),
      builder: (_, __) => const HomeScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        shape: const Border(),
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: IndexedStack(
                  index: provider.indexSelected,
                  children: [
                    const PrincipalScreen(),
                    ProductsScreen.init(context),
                    const CartScreen(),
                    const FavoritesScreen(),
                    const ProfileScreen(),
                  ],
                )),
                _NavigationBar(
                  index: provider.indexSelected,
                  onIndexSelected: (index) {
                    provider.updateIndex(index);
                  },
                ),
              ],
            ),
            Positioned.fill(
              child: provider.userStatus == UserStatus.unidentified || cartProvider.state == ProductsState.inPurchase? 
              const ScreenLoading()
              : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
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
    final provider = Provider.of<HomeProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
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
                  Icons.home_outlined,
                ),
              ),
              IconButton(
                onPressed: () => onIndexSelected(1),
                icon: Icon(
                  color: index == 1 ? AppColors.green : AppColors.lightGrey,
                  Icons.store_outlined,
                ),
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.purple,
                    child: IconButton(
                      onPressed: () => onIndexSelected(2),
                      icon: Icon(
                        color: index == 2 ? AppColors.green : AppColors.white,
                        Icons.shopping_basket_outlined,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: cartProvider.totalItems == 0
                        ? const SizedBox.shrink()
                        : CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColors.pink,
                            child: Text('${cartProvider.totalItems}'),
                          ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => onIndexSelected(3),
                icon: Icon(
                  color: index == 3 ? AppColors.green : AppColors.lightGrey,
                  Icons.favorite_border_outlined,
                ),
              ),
              InkWell(
                onTap: () => onIndexSelected(4),
                child: CircleAvatar(
                  radius: 15,
                  child: ClipOval(
                    child: provider.user?.image != null
                        ? Image.asset(
                            provider.user!.image!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.person_2_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
