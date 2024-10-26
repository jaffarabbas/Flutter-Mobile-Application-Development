part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessSate extends CartState {
  final List<ProductDataModel> products;

  CartSuccessSate({required this.products});
}

class CartRemoveCartItemActionState extends CartActionState {}
