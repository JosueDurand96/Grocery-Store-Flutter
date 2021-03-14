import 'package:flutter/cupertino.dart';
import 'package:grocery_store/bloc/grocery_store_bloc.dart';

class GroceryProvider extends InheritedWidget {
  final GroceryStoreBloc bloc;
  final Widget child;

  GroceryProvider({@required this.bloc, @required this.child}) : super(child: child);
  static GroceryProvider of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<GroceryProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
