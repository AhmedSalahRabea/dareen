// ignore_for_file: use_key_in_widget_constructors

import 'package:dareen_app/shared/cubit/app_cubit.dart';
import 'package:dareen_app/shared/widgets/my_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactsWidget extends StatelessWidget {
  final String whatsappString;
  final String callString;
  final double screenHeightDivideNumber;

  const ContactsWidget({
    required this.whatsappString,
    required this.callString,
    required this.screenHeightDivideNumber,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyOutLineButton(
          text: whatsappString,
          screenHeightDivideNumber: screenHeightDivideNumber,
          icon: FontAwesomeIcons.whatsappSquare,
          function: () {
            AppCubit.get(context).openWhatapp(context);
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 80,
        ),
        MyOutLineButton(
          text: callString,
          screenHeightDivideNumber: screenHeightDivideNumber,
          icon: FontAwesomeIcons.phone,
          function: () {
            AppCubit.get(context).callPhone(context);
          },
        ),
      ],
    );
  }
}
