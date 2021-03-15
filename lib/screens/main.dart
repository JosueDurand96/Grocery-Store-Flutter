import 'package:flutter/material.dart';
import 'package:grocery_store/provider/grocery_provider.dart';
import 'package:grocery_store/bloc/grocery_store_bloc.dart';
import 'package:grocery_store/screens/grocery_store_list.dart';
import 'package:grocery_store/utils/Colors.dart';

void main() {
  runApp(MyApp());
}


const cartBarHeight = 170.0;
const _panelTransition = Duration(microseconds: 500);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery Store',
      color: Colors.red,
      home: GroceryStoreHome(),
    );
  }
}

class GroceryStoreHome extends StatefulWidget {
  @override
  _GroceryStoreHomeState createState() => _GroceryStoreHomeState();
}

class _GroceryStoreHomeState extends State<GroceryStoreHome> {
  final bloc = GroceryStoreBloc();

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta < -7) {
      bloc.changeToCart();
    } else if (details.primaryDelta > 12) {
      bloc.changeToNormal();
    }
  }

  double _getTopForWhitePanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return -cartBarHeight;
    } else if (state == GroceryState.cart) {
      return -(size.height - kToolbarHeight - cartBarHeight / 2);
    }
    return 0.0;
  }

  double _getTopForBlackPanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return size.height - kToolbarHeight - cartBarHeight;
    } else if (state == GroceryState.cart) {
      return cartBarHeight / 2;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GroceryProvider(
      bloc: bloc,
      child: AnimatedBuilder(
        animation: bloc,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                _AppBarGrocery(),
                Expanded(
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        curve: Curves.decelerate,
                        duration: _panelTransition,
                        left: 0,
                        right: 0,
                        top: _getTopForWhitePanel(bloc.groceryState, size),
                        height: size.height - kToolbarHeight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: GroceryStoreList(),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        curve: Curves.decelerate,
                        duration: _panelTransition,
                        left: 0,
                        right: 0,
                        top: _getTopForBlackPanel(bloc.groceryState, size),
                        height: size.height,
                        child: GestureDetector(
                          onVerticalDragUpdate: _onVerticalGesture,
                          child: Container(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AppBarGrocery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0),
      height: kToolbarHeight,
      color: backgroundColor,
      child: Row(
        children: [
          BackButton(
            color: Colors.black,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              "Fruits and vegetables",
              style: TextStyle(color: Colors.black),
            ),
          ),
          IconButton(icon: Icon(Icons.settings), onPressed: () => null)
        ],
      ),
    );
  }
}
