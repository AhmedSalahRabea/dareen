// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, non_constant_identifier_names

import 'package:dareen_app/home/home_screen.dart';
import 'package:dareen_app/modules/otp_screen/otp_screen_widgets/otp_intro_text.dart';
import 'package:dareen_app/modules/otp_screen/otp_screen_widgets/pin_code_fields.dart';
import 'package:dareen_app/modules/otp_screen/otp_screen_widgets/next_verify_button.dart';
import 'package:dareen_app/modules/register_screen/cubit/register_cubit.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  final String password_confirmation;
  final String region;
  final String address;

  OtpScreen({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.password_confirmation,
    required this.region,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
      if (state is LoadingPhoneAuth) {
        return showProgressIndicator(context);
      }
      if (state is RegisterSuccess) {
        Navigator.pop(context);
        // ignore: prefer_const_constructors
        navigateAndFinish(context: context, screen: HomeScreen());
      }
      if (state is ErrorOnPhoneAuth) {
        // Navigator.pop(context);
        String erroMsg = state.error;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(erroMsg),
          backgroundColor: Colors.black,
          duration: const Duration(
            seconds: 5,
          ),
        ));
      }
    }, builder: (context, state) {
      RegisterCubit cubit = RegisterCubit.get(context);
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
              child: Column(
                children: [
                  // ignore: prefer_const_constructors
                  OtpIntroText(),
                  const SizedBox(height: 88),
                  PinCodeFields(),
                  const SizedBox(height: 60),
                  if (cubit.isVerifyButtonEnabled)
                    NextOrVerifyButton(
                      function: () {
                        showProgressIndicator(context);
                        try {
                          cubit.submitOTP(
                            cubit.otpCode!,
                            name: name,
                            phoneNumber: phoneNumber,
                            email: email,
                            password: password,
                            password_confirmation: password_confirmation,
                            region: region,
                            address: address,
                            context: context,
                          );
                        } catch (e) {
                          mySnackBar(
                            content:
                                'حدث خطأ أثناء التسجيل برجاء المحاولة مرة أخري ',
                            context: context,
                          );
                        }
                      },
                      buttonName: 'تأكيد',
                    ),
                  if (!cubit.isVerifyButtonEnabled)
                    NextOrVerifyButton(
                      function: null,
                      buttonName: 'تأكيد',
                    ),

                  //  _buildPhoneVerificationBloc(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
