import 'package:flutter/material.dart';
import 'package:grocery_store/provider/grocery_provider.dart';

class GroceryStoreCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context).bloc;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Cart',
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: bloc.cart.length,
                      itemBuilder: (context, index) {
                        final item = bloc.cart[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(item.product.image),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                item.quantity.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                item.product.name,
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              Text(
                                '\$' +
                                    (item.product.price * item.quantity)
                                        .toStringAsFixed(2),
                                style: TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.white,),
                                onPressed: () {
                                  bloc.deleteProduct(item);
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(
                'Total',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                '\$' + bloc.totalPriceElements().toStringAsFixed(2),
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 35.0, left: 15.0, right: 15.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Color(0xFFF4C459),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Next',
                style: TextStyle(color: Colors.black),
              ),
            ),
            onPressed: () => null,
          ),
        ),
      ],
    );
  }
}
