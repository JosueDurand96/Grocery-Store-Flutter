import 'package:flutter/material.dart';
import 'package:grocery_store/provider/grocery_provider.dart';
import 'package:grocery_store/screens/main.dart';

class GroceryStoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context).bloc;
    return Container(
      color: Colors.green,
      child: StaggeredDualView(
        itemBuilder: (context, index) {
          final product = bloc.catalog[index];
          return Card(
            color: Colors.white,
            child: Column(
              children: [
                Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ],
            ),
          );
        },
        itemCount: bloc.catalog.length,
      ),
    );

    //return Stagg
    // return ListView.builder(
    //     padding: const EdgeInsets.only(top: cartBarHeight),
    //     itemCount: bloc.catalog.length,
    //     itemBuilder: (context, index) {
    //       return Container(
    //         height: 100.0,
    //         width: 100.0,
    //         color: Colors.primaries[index % Colors.primaries.length],
    //       );
    //     });
  }
}

class StaggeredDualView extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;

  const StaggeredDualView(
      {Key key,
      @required this.itemBuilder,
      @required this.itemCount,
      this.spacing = 0.0,
      this.aspectRatio = 0.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final itemHeight = (width * 0.5) / aspectRatio;
        final height = constraints.maxHeight + itemHeight;
        return OverflowBox(
          maxWidth: width,
          minWidth: width,
          maxHeight: height,
          minHeight: height,
          child: GridView.builder(
            padding: EdgeInsets.only(top: itemHeight / 2, bottom: itemHeight),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: aspectRatio,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Transform.translate(
                offset: Offset(0.0, index.isOdd ? itemHeight * 0.5 : 0.0),
                child: itemBuilder(context, index),
              );
            },
          ),
        );
      },
    );
  }
}
