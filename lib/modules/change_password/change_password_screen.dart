// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:buildcondition/buildcondition.dart';
import 'package:dareen_app/home/home_screen.dart';
import 'package:dareen_app/modules/login/cubit/login_cubit.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/widgets/my_default_button.dart';
import 'package:dareen_app/shared/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reNewPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is ChangePasswordFailedWrongPassword) {
          mySnackBar(
              context: context, content: 'كلمة المرور التي أدخلتها غير صحيحة');
        }
        if (state is ChangePasswordSuccess) {
          mySnackBar(
              context: context, content: 'تم تغير كلمة السر بنجاح');
          navigateAndFinish(context: context, screen: HomeScreen());
        }
         if (state is ChangePasswordError) {
          mySnackBar(
              context: context, content: 'تأكد من الإتصال بالإنترنت و أعد المحاولة مرة أخري');
        }
      },
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('تغيير كلمة المرور'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              reverse: true,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height / 7,
                      width: double.infinity,
                      child: Image.asset('assets/images/login/dareen.jpg'),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'من فضلك قم بإدخال كلمة المرور القديمة والجديدة',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 40),
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
                      label: 'الرقم السري القديم',
                      prefix: Icons.lock_outline,
                      isPassword: cubit.isPassword,
                      suffix: cubit.suffix,
                      suffixPressed: () {
                        cubit.changePasswordVisibilty();
                      },
                    ),
                    const SizedBox(height: 30),
                    MyTextFormField(
                      controller: newPasswordController,
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
                      label: 'الرقم السري الجديد',
                      prefix: Icons.lock_outline,
                      isPassword: cubit.isPassword,
                      suffix: cubit.suffix,
                      suffixPressed: () {
                        cubit.changePasswordVisibilty();
                      },
                    ),
                    const SizedBox(height: 30),
                    MyTextFormField(
                      controller: reNewPasswordController,
                      type: TextInputType.visiblePassword,
                      validate: (value) {
                        if (newPasswordController.text !=
                                reNewPasswordController.text ||
                            value.isEmpty) {
                          return 'من فضلك أدخل رفم مطابق للرقم السري الجديد';
                        } else {
                          return null;
                        }
                      },
                      label: 'تأكيد كلمة المرور',
                      prefix: Icons.lock_outline,
                      isPassword: cubit.isPassword,
                      suffix: cubit.suffix,
                      suffixPressed: () {
                        cubit.changePasswordVisibilty();
                      },
                    ),
                    const SizedBox(height: 30),
                    BuildCondition(
                      condition: state is! ChangePasswordLoading,
                      builder: (context) => MyDefaultButton(
                        text: 'تغيير كلمة المرور',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            cubit.changeUserPassword(
                              oldPassword: passwordController.text,
                              newPassword: newPasswordController.text,
                            );
                          }
                        },
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
