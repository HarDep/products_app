import 'package:flutter/material.dart';
import 'package:products_app/presentation/widgets/loading_widgets.dart';

typedef ItemBuild = Widget? Function(BuildContext, int);

class GridViewListAsChild extends StatelessWidget {
  final String title;
  final bool conditionList;
  final int itemsLength;
  final ItemBuild itemBuild;
  
  const GridViewListAsChild({
    super.key,
    required this.title,
    required this.conditionList,
    required this.itemsLength,
    required this.itemBuild,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridViewList(
        title: title,
        conditionList: conditionList,
        itemsLength: itemsLength,
        itemBuild: itemBuild,
      ),
    );
  }
}

class GridViewList extends StatelessWidget {
  final String title;
  final bool conditionList;
  final int itemsLength;
  final ItemBuild itemBuild;
  
  const GridViewList({
    super.key,
    required this.title,
    required this.conditionList,
    required this.itemsLength,
    required this.itemBuild,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).cardColor),
          ),
        ),
        GridList(conditionList: conditionList, itemsLength: itemsLength, itemBuild: itemBuild),
      ],
    );
  }
}

class GridList extends StatelessWidget {
  final bool conditionList;
  final int itemsLength;
  final ItemBuild itemBuild;

  const GridList({super.key, required this.conditionList, required this.itemsLength, required this.itemBuild});

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: conditionList?
          GridView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: itemsLength,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            itemBuilder: itemBuild,
          )
          : const ListLoading(),
        );
  }
}
