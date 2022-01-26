// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, avoid_print

import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/home/home_screen.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/modules/login/login_screen.dart';
import 'package:dareen_app/modules/otp_screen/otp_screen.dart';

import 'package:dareen_app/modules/register_screen/cubit/register_cubit.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:dareen_app/shared/widgets/my_default_button.dart';
import 'package:dareen_app/shared/widgets/my_text_field.dart';
import 'package:dareen_app/shared/widgets/my_textbutton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  //form fields controller
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  //form key
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) async {
          if (state is LoadingPhoneAuth) {
            return showProgressIndicator(context);
          }
          if (state is PhoneNumberSubmitted) {
            Navigator.pop(context);
            navigateTo(
                context: context,
                screen: OtpScreen(
                  name: nameController.text,
                  phoneNumber: phoneController.text,
                  password: passwordController.text,
                  password_confirmation: rePasswordController.text,
                  region: regionController.text,
                  address: addressController.text,
                ));
          }
          if (state is ErrorOnPhoneAuth) {
            Navigator.pop(context);
            String erroMsg = state.error;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(erroMsg),
              backgroundColor: Colors.black,
              duration: const Duration(
                seconds: 5,
              ),
            ));
          }

          if (state is RegisterSuccess) {
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
                nameController.clear();
                phoneController.clear();
                passwordController.clear();
                rePasswordController.clear();
                regionController.clear();
                addressController.clear();
                ShopCubit.get(context).getCategoryData(context);
                ShopCubit.get(context).getAllProducts();
                ShopCubit.get(context).getFavourites(userId);
                CartCubit.get(context).getCartProducts();
              }).catchError((error) {
                print(error.toString());
              });
            } else if (state.loginModel.status == false) {
              showMyAlertDialog(
                context: context,
                title: 'خطأ أثناء التسجيل',
                isBarrierDismissible: false,
                content: Text(
                  '${state.loginModel.error![0]}',
                  textDirection: TextDirection.rtl,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      navigateAndFinish(
                          context: context, screen: LoginScreen());
                    },
                    child: const Text(
                      'حسناً',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            }
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 220,
                        width: double.infinity,
                        child: Image.asset('assets/images/login/dareen.jpg'),
                      ),
                      Text(
                        'قم بالتسجيل لتستمتع بجميع خدمات تطبيق دارين',
                        maxLines: 3,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                              // fontSize: 18,
                            ),
                      ),
                      const SizedBox(height: 12),
                      MyTextFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'من فضلك أدخل الإسم بشكل صحيح';
                          } else if (value.length < 7) {
                            return 'من فضلك أدخل الإسم ثنائي أو أكثر ';
                          } else {
                            return null;
                          }
                        },
                        label: 'الإسم بالكامل',
                        prefix: Icons.person,
                      ),
                      const SizedBox(height: 20), // Text(
                      MyTextFormField(
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
                        onSaved: (value) {
                          cubit.phoneNumber = value!;
                          print(cubit.phoneNumber);
                        },
                        label: 'رقم الهاتف',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(height: 20),
                      MyTextFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'من فضلك أدخل رفم سري صحيح';
                          } else if (value.length < 7) {
                            return 'يجب ألا يقل الرقم السري عن سبع خانات';
                          } else {
                            return null;
                          }
                        },
                        label: 'الرقم السري',
                        prefix: Icons.lock_outline,
                        isPassword: cubit.isPassword,
                        suffix: cubit.suffix,
                        suffixPressed: () {
                          cubit.changePasswordVisibilty();
                        },
                      ),
                      const SizedBox(height: 20),
                      MyTextFormField(
                        controller: rePasswordController,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          if (passwordController.text !=
                              rePasswordController.text) {
                            return 'من فضلك أدخل رفم سري صحيح';
                          } else {
                            return null;
                          }
                        },
                        label: ' أعد كتابة الرقم السري',
                        prefix: Icons.lock_outline,
                        isPassword: cubit.isPassword,
                        suffix: cubit.suffix,
                        suffixPressed: () {
                          cubit.changePasswordVisibilty();
                        },
                      ),
                      const SizedBox(height: 20),
                      MyTextFormField(
                        controller: regionController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value.isEmpty || value.length < 3) {
                            return 'من فضلك أدخل المنطقة التي تسكن فيها مثل (شرق الكوبري - النقطة إلخ)';
                          } else {
                            return null;
                          }
                        },
                        label: 'المنطقة',
                        prefix: Icons.location_city,
                      ),
                      const SizedBox(height: 20),
                      MyTextFormField(
                        controller: addressController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value.isEmpty || value.length < 12) {
                            return 'من فضلك أدخل العنوان بالتفصيل حتي نستطيع الوصول إليكم بسهولة';
                          } else {
                            return null;
                          }
                        },
                        label: 'العنوان بالتفصيل',
                        prefix: Icons.cottage,
                        isDetailedAddress: true,
                      ),
                      const SizedBox(height: 20),
                      MyDefaultButton(
                        text: 'التسجيل',
                        function: () async {
                          showProgressIndicator(context);
                          //to subscribe to all users topic
                          await FirebaseMessaging.instance
                              .subscribeToTopic('allUsers');
                          if (!formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            return;
                          } else {
                            Navigator.pop(context);
                            formKey.currentState!.save();
                            cubit.submitPhoneNumber(cubit.phoneNumber!);
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'هل لديك حساب بالفعل ؟',
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                          MyTextButton(
                            text: 'تسجيل الدخول',
                            fontSize: 16,
                            onpressed: () {
                              navigateAndFinish(
                                  context: context, screen: LoginScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
