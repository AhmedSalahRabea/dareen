// ignore_for_file: avoid_unnecessary_containers, avoid_print, use_key_in_widget_constructors, must_be_immutable

import 'package:dareen_app/modules/register_screen/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeFields extends StatelessWidget {
  // late String otpCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          borderWidth: 1.0,
          activeColor: Colors.deepOrange,
          inactiveColor: Colors.deepOrange,
          inactiveFillColor: Colors.white,
          activeFillColor: Colors.deepOrange,
          selectedColor: Colors.blue,
          selectedFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        enablePinAutofill: true,
        textStyle: const TextStyle(color: Colors.white),
        onCompleted: (code) {
          BlocProvider.of<RegisterCubit>(context).otpCode = code;
          BlocProvider.of<RegisterCubit>(context).changeVerifyButtonEnabled();

          print("Completed");
        },
        onChanged: (value) {
          // print(value);
        },
        // beforeTextPaste: (text) {
        //   print("Allowing to paste $text");
        //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
        //   return true;
        // },
      ),
    );
  }
}
