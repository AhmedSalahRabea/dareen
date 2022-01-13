// ignore_for_file: use_key_in_widget_constructors

import 'package:dareen_app/shared/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactsWidget extends StatelessWidget {
  final String whatsappString;
  final String callString;

  const ContactsWidget({
    required this.whatsappString,
    required this.callString,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, right: 20, left: 20, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: double.infinity,
            height: 40,
            child: OutlinedButton.icon(
              onPressed: () {
                AppCubit.get(context).openWhatapp(context);
              },
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  FontAwesomeIcons.whatsappSquare,
                  color: Color(0xff25d366),
                ),
              ),
              label:  Text(whatsappString),
              style: OutlinedButton.styleFrom(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16),
                side: const BorderSide(
                  width: 1,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: OutlinedButton.icon(
              onPressed: () {
                AppCubit.get(context).callPhone(context);
              },
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  FontAwesomeIcons.phone,
                  color: Color(0xff25d366),
                ),
              ),
              label:  Text(callString),
              style: OutlinedButton.styleFrom(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16),
                side: const BorderSide(width: 1, color: Colors.deepOrange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
