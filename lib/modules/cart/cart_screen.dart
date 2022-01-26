// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/modules/cart/cart_item.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/widgets/my_default_button.dart';
import 'package:dareen_app/shared/widgets/my_ok_text.dart';
import 'package:dareen_app/shared/widgets/no_internet_or_noproducts.dart';
import 'package:dareen_app/shared/widgets/empty_list.dart';
import 'package:dareen_app/shared/widgets/my_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return BlocConsumer<CartCubit, CartState>(
                listener: (context, state) {
              if (state is ConfirmOrderSuccess) {
                CartCubit.get(context).getCartProducts();
              }
              if (state is ConfirmOrderLoading) {
                Navigator.pop(context);
                showProgressIndicator(context);
              }
              if (state is ConfirmOrderSuccess) {
                showMyAlertDialog(
                  context: context,
                  title: 'تم تأكيد الطلب بنجاح',
                  content: const Icon(
                    FontAwesomeIcons.checkDouble,
                    color: Colors.green,
                    size: 50,
                  ),
                  actions: [
                    const MyOkTextButtonForDailog(
                      fontSize: 20,
                    )
                  ],
                );
              }
            }, builder: (context, state) {
              CartCubit cubit = CartCubit.get(context);

              return Column(
                // alignment: AlignmentDirectional.bottomCenter,
                children: [
                  BuildCondition(
                    condition: cubit.cartProducts.isNotEmpty,
                    builder: (context) => Expanded(
                      child: ListView.separated(
                        itemBuilder: (_, index) {
                          return CartItem(
                            model: cubit.cartProducts[index],
                          );
                        },
                        separatorBuilder: (contextm, index) =>
                            const MyDivider(),
                        itemCount: cubit.cartProducts.length,
                      ),
                    ),
                    fallback:
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
                  if (state is! GetCartLoading && cubit.cartProducts.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            showMyAlertDialog(
                              context: context,
                              isBarrierDismissible: false,
                              title: 'تأكيد الطلب',
                              content: Column(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.check,
                                    color: Colors.green,
                                    size: 50,
                                  ),
                                  const SizedBox(height: 20),
                                  // const Text(
                                  //   'هل أنت متأكد من شراء المنتجات الان',
                                  //   textDirection: TextDirection.rtl,
                                  //   style: TextStyle(
                                  //       color: Colors.black, fontSize: 16),
                                  // ),
                                  Text(
                                    'قيمة المنتجات  ${cubit.totalPriceForAllProductsInTheCart} جنيه ',
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  const Text(
                                    'مصاريف التوصيل +',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const MyOkTextButtonForDailog(
                                      okOrCancel: 'إلغاء',
                                    ),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: MyDefaultButton(
                                          text: 'تأكيد',
                                          width: width / 4,
                                          function: () {
                                            print(
                                                '==== ${cubit.producIdAndQuantityMap.values.toList()}');
                                            cubit
                                                .confirmOrder(
                                                  cartId: cubit.cartProducts
                                                      .elementAt(0)
                                                      .cartId,
                                                  productIdAndQuantity: cubit
                                                      .producIdAndQuantityMap
                                                      .values
                                                      .toList(),
                                                )
                                                .then((value) =>
                                                    Navigator.pop(context));
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'أطلب',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${cubit.totalPriceForAllProductsInTheCart} جنيه',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).primaryColor.withOpacity(.9),
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
      ),
    );
  }
}
