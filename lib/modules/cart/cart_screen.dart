// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/modules/cart/cart_item.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/shared/widgets/no_internet_or_noproducts.dart';
import 'package:dareen_app/shared/widgets/empty_list.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
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
                      fallback:
                          // (state is GetCartSuccess || state is DeleteProductFromCartSuccess) && cubit.cartProducts.isEmpty
                          state is CartEmptyState && cubit.cartProducts.isEmpty
                              ? (context) => Center(
                                    child: EmptyList(
                                      image: 'assets/images/emptyCart2.png',
                                      text: 'لا يوجد لديك منتجات في السلة',
                                    ),
                                  )
                              : (context) => const Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(top: 100.0),
                                    child: CircularProgressIndicator(),
                                  )),
                    ),
                    if (state is! GetCartLoading &&
                        cubit.cartProducts.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {
                              //CartCubit.get(context).addProductToCart(product: model);
                            },
                            // icon: const Icon(
                            //   Icons.online_prediction_sharp,
                            //   color: Colors.white,
                            // ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  'أطلب',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '120',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              });
        } else {
          return NoInterNetOrNoProducts(
            icon: Icons.signal_wifi_connected_no_internet_4,
            text: 'يرجي فحص الإتصال بالإنترنت',
          );
        }
      },
      child: const CircularProgressIndicator(),
    );
  }
}
