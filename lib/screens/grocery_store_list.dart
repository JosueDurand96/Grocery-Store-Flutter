import 'package:flutter/material.dart';
import 'package:grocery_store/provider/grocery_provider.dart';
import 'package:grocery_store/screens/grocery_store_details.dart';
import 'package:grocery_store/screens/main.dart';
import 'package:grocery_store/utils/Colors.dart';
import 'package:grocery_store/widgets/staggered_dual_view.dart';

class GroceryStoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context).bloc;
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.only(top: cartBarHeight),
      child: StaggeredDualView(
        aspectRatio: 0.82,
        itemPercent: 0.25,
        itemBuilder: (context, index) {
          final product = bloc.catalog[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, __) {
                    return FadeTransition(
                      opacity: animation,
                      child: GroceryStoreDetails(
                        product: product,
                      ),
                    );
                  },
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 10,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: 'list_${product.name}',
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '\$' + product.price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 19,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      product.weight,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
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