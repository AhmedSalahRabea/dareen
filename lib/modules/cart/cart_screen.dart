// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/modules/cart/cart_item.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          CartCubit cubit = CartCubit.get(context);
          return Column(
            // alignment: AlignmentDirectional.bottomCenter,
            children: [
              BuildCondition(
                condition: cubit.cartProducts.isNotEmpty,
                builder: (context) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: Expanded(
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        return CartItem(
                          model: cubit.cartProducts[index],
                        );
                      },
                      separatorBuilder: (contextm, index) => MyDivider(),
                      itemCount: cubit.cartProducts.length,
                    ),
                  ),
                ),
                fallback: state is GetCartSuccess && cubit.cartProducts.isEmpty
                    ? (context) => const Center(
                            child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'no items found',
                            //  style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ))
                    : (context) => const Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 100.0),
                          child: CircularProgressIndicator(),
                        )),
              ),
              if (state is! GetCartLoading)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        //CartCubit.get(context).addProductToCart(product: model);
                      },
                      icon: const Icon(
                        Icons.money_off_csred_rounded,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'أطلب الان',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.deepOrange.withOpacity(.9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ),
            ],
          );
        });
  }
}
