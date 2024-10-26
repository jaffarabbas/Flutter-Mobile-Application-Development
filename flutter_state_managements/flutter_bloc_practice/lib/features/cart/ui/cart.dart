import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practice/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_practice/features/cart/ui/cart_title_widget.dart';
import 'package:flutter_bloc_practice/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_practice/features/home/ui/product_title_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBlock = CartBloc();
  @override
  void initState() {
    cartBlock.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text('Cart'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBlock,
        listener: (context, state) {
          if (state is CartRemoveCartItemActionState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Item Remove From Cart')));
          }
        },
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessSate:
              final successState = state as CartSuccessSate;
              return ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return CartTitleWidget(
                      cartBloc: cartBlock,
                      productDataModel: successState.products[index]);
                },
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
