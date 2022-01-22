// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:dareen_app/modules/register_screen/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpIntroText extends StatelessWidget {
  OtpIntroText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'قم بتأكيد رقم الهاتف الخاص بك',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: RichText(
              text: TextSpan(
                // text: 'Enter your 6 digits code numbers sent to ',
                text: 'من فضلك أدخل الكود الذي تم إرساله إلي ',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  height: 1.4,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '${BlocProvider.of<RegisterCubit>(context).phoneNumber}',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
