// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/modules/login/cubit/login_cubit.dart';
import 'package:dareen_app/modules/register_screen/register_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/widgets/my_default_button.dart';
import 'package:dareen_app/shared/widgets/my_ok_text.dart';
import 'package:dareen_app/shared/widgets/my_text_field.dart';
import 'package:dareen_app/shared/widgets/my_textbutton.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              //appBar: AppBar(),
              backgroundColor: Colors.white,

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
                            height: 250,
                            width: double.infinity,
                            child:
                                Image.asset('assets/images/login/dareen.jpg')),
                        Text(
                          'قم بتسجيل الدخول لتستمتع بجميع خدمات تطبيق دارين',
                          maxLines: 3,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.deepOrange),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  generateCountryFlag() + ' +2',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 2.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
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
                        const SizedBox(height: 30),
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
                        const SizedBox(height: 4),
                        MyTextButton(
                          text: 'هل نسيت كلمة السر ؟',
                          onpressed: () {
                            showMyAlertDialog(
                              context: context,
                              title: 'هل نسيت كلمة السر',
                              content: 'تم الضغط علي هل نسيت كلمة السر',
                              actions: [MyOkTextButtonForDailog()],
                              isBarrierDismissible: false,
                            );
                            mySnackBar(
                              context: context,
                              content: 'تم الضغط علي هل نسيت كلمة السر ',
                            );
                          },
                          fontSize: 14,
                        ),
                        //  const SizedBox(height: 7),
                        BuildCondition(
                          condition: state is! LoginLoading,
                          builder: (context) => MyDefaultButton(
                            text: 'تسجيل الدخول',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                cubit.userLogin(
                                  phoneNumber: phoneController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'لا يوجد لديك حساب ؟ ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                            MyTextButton(
                              text: 'إنشاء حساب جديد ',
                              fontSize: 16,
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
      ),
    );
  }
}
