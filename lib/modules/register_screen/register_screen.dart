// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, avoid_print

import 'package:dareen_app/modules/login/login_screen.dart';
import 'package:dareen_app/modules/otp_screen/otp_screen.dart';

import 'package:dareen_app/modules/register_screen/cubit/register_cubit.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/widgets/my_default_button.dart';
import 'package:dareen_app/shared/widgets/my_text_field.dart';
import 'package:dareen_app/shared/widgets/my_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  //form fields controller
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
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
                  email: emailController.text,
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
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 220,
                          width: double.infinity,
                          child: Image.asset('assets/images/login/dareen.jpg'),
                        ),
                        Text(
                          '???? ???????????????? ?????????????? ?????????? ?????????? ?????????? ??????????',
                          maxLines: 3,
                          textAlign: TextAlign.right,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
                              return '???? ???????? ???????? ?????????? ???????? ????????';
                            } else if (value.length < 7) {
                              return '???? ???????? ???????? ?????????? ?????????? ???? ???????? ';
                            } else {
                              return null;
                            }
                          },
                          label: '?????????? ??????????????',
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 20), // Text(
                        MyTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return '???? ???????? ???????? ?????? ????????????';
                            } else if (value.length < 11) {
                              return '?????? ???? ???????? ?????? ???????????? ???????? ???? 11 ??????';
                            } else if (value.length > 11) {
                              return '?????? ???? ???????? ?????? ???????????? ???????? ???? 11 ??????';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            cubit.phoneNumber = value!;
                            print(cubit.phoneNumber);
                          },
                          label: '?????? ????????????',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 20),
                        MyTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return '???? ???????? ???????? ??????????????';
                            } else if (!value.contains('@')) {
                              return '???? ???????? ???????? ?????????????? ???????? ????????';
                            } else {
                              return null;
                            }
                          },
                          label: '???????????? ??????????????????????',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(height: 20),
                        MyTextFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value.isEmpty) {
                              return '???? ???????? ???????? ?????? ?????? ????????';
                            } else if (value.length < 7) {
                              return '?????? ?????? ?????? ?????????? ?????????? ?????? ???? ??????????';
                            } else {
                              return null;
                            }
                          },
                          label: '?????????? ??????????',
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
                              return '???? ???????? ???????? ?????? ?????? ????????';
                            } else {
                              return null;
                            }
                          },
                          label: ' ?????? ?????????? ?????????? ??????????',
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
                              return '???? ???????? ???????? ?????????????? ???????? ???????? ???????? ?????? (?????? ?????????????? - ???????????? ??????)';
                            } else {
                              return null;
                            }
                          },
                          label: '??????????????',
                          prefix: Icons.location_city,
                        ),
                        const SizedBox(height: 20),
                        MyTextFormField(
                          controller: addressController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty || value.length < 12) {
                              return '???? ???????? ???????? ?????????????? ???????????????? ?????? ???????????? ???????????? ?????????? ????????????';
                            } else {
                              return null;
                            }
                          },
                          label: '?????????????? ????????????????',
                          prefix: Icons.cottage,
                          isDetailedAddress: true,
                        ),
                        const SizedBox(height: 20),
                        MyDefaultButton(
                          text: '??????????????',
                          function: () async {
                            showProgressIndicator(context);
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
                              '???? ???????? ???????? ???????????? ??',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                            MyTextButton(
                              text: '?????????? ????????????',
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
            ),
          );
        },
      ),
    );
  }
}
