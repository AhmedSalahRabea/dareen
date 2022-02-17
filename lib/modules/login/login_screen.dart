// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors, avoid_print

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/home/home_screen.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/modules/login/cubit/login_cubit.dart';
import 'package:dareen_app/modules/register_screen/register_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:dareen_app/shared/widgets/my_default_button.dart';
import 'package:dareen_app/shared/widgets/my_ok_text.dart';
import 'package:dareen_app/shared/widgets/my_text_field.dart';
import 'package:dareen_app/shared/widgets/my_textbutton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

//this method to generate the egyption flag
  String generateCountryFlag() {
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          if (state.loginModel.status) {
            await saveUserDataInSharedPref(
              token: state.loginModel.token!,
              userId: state.loginModel.data!.id,
              userName: state.loginModel.data!.name,
              phoneNumber: state.loginModel.data!.phoneNumber,
              userRegion: state.loginModel.data!.region,
              userAddress: state.loginModel.data!.address,
            ).then((value) {
              userId = state.loginModel.data!.id;
              navigateAndFinish(context: context, screen: HomeScreen());
              phoneController.clear();
              passwordController.clear();
              ShopCubit.get(context).allProducts = [];
              ShopCubit.get(context).products = [];
              CartCubit.get(context).cartProducts = [];
              ShopCubit.get(context).getCategoryData(context);
              ShopCubit.get(context).getAllProducts();
              ShopCubit.get(context).getFavourites(userId);
              CartCubit.get(context).getCartProducts();
              navigateAndFinish(context: context, screen: HomeScreen());
            }).catchError((error) {
              print(error.toString());
            });
          } else {
            showMyAlertDialog(
              context: context,
              title: ' خطأ أثناء تسجيل الدخول',
              content: Text(
                state.loginModel.message!,
                textDirection: TextDirection.rtl,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              actions: [
                MyOkTextButtonForDailog(),
              ],
            );
          }
        }
      },
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 32.h,
                          width: double.infinity,
                          child: Image.asset('assets/images/login/logo.png')),
                      Text(
                        'قم بتسجيل الدخول لتستمتع بجميع خدمات تطبيق دارين',
                        maxLines: 3,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 11.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 5.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  generateCountryFlag() + ' +2',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 14.sp),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            flex: 3,
                            child: MyTextFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'من فضلك أدخل رقم الهاتف';
                                } else if (value.length < 11) {
                                  return 'يجب أن يكون رقم الهاتف مكون من 11 رقم';
                                } else if (value.length > 11) {
                                  return 'يجب أن يكون رقم الهاتف مكون من 11 رقم';
                                } else {
                                  return null;
                                }
                              },
                              label: 'رقم الهاتف',
                              prefix: Icons.phone,
                              autofillHints: const [
                                AutofillHints.telephoneNumber
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      MyTextFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'من فضلك أدخل رفم سري صحيح';
                          } else {
                            return null;
                          }
                        },
                        onsubmit: (value) {
                          if (formKey.currentState!.validate()) {}
                        },
                        label: 'الرقم السري',
                        prefix: Icons.lock_outline,
                        isPassword: cubit.isPassword,
                        suffix: cubit.suffix,
                        suffixPressed: () {
                          cubit.changePasswordVisibilty();
                        },
                      ),
                      SizedBox(height: 5.h),
                      // MyTextButton(
                      //   text: 'هل نسيت كلمة السر ؟',
                      //   onpressed: () {
                      //     showMyAlertDialog(
                      //       context: context,
                      //       title: 'هل نسيت كلمة السر',
                      //       content: 'تم الضغط علي هل نسيت كلمة السر',
                      //       actions: [MyOkTextButtonForDailog()],
                      //       isBarrierDismissible: false,
                      //     );
                      //   },
                      //   fontSize: 14,
                      // ),
                      //  const SizedBox(height: 7),
                      BuildCondition(
                        condition: state is! LoginLoading,
                        builder: (context) => MyDefaultButton(
                          text: 'تسجيل الدخول',
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              await cubit.userLogin(
                                phoneNumber: phoneController.text,
                                password: passwordController.text,
                                context: context,
                              );
                              //to subscribe to all users topic
                              await FirebaseMessaging.instance
                                  .subscribeToTopic('allUsers');
                            }
                          },
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('لا يوجد لديك حساب ؟ ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 10.sp)
                              // .copyWith(color: Colors.black),
                              ),
                          MyTextButton(
                            text: 'إنشاء حساب جديد ',
                            fontSize: 8.sp,
                            onpressed: () {
                              navigateAndFinish(
                                  context: context, screen: RegisterScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
