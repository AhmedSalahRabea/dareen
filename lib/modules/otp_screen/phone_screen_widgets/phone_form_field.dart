
// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:dareen_app/modules/register_screen/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PhoneFormField extends StatelessWidget {
  String generateCountryFlag() {
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding:const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              generateCountryFlag() + ' +2',
              style:const TextStyle(
                fontSize: 18,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
       const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding:const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              autofocus: true,
              style:const TextStyle(
                fontSize: 18,
                letterSpacing: 2.0,
              ),
              decoration:const InputDecoration(border: InputBorder.none),
              cursorColor: Colors.black,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please Enter your phone number';
                } else if (value.length < 11) {
                  return 'Too short for a phone number';
                }else if (value.length > 11) {
                  return 'Too long for a phone number';
                }
                return null;
              },
              onSaved: (value) {
                BlocProvider.of<RegisterCubit>(context).phoneNumber = value!;
              },
            ),
          ),
        ),
      ],
    );
  }
}
