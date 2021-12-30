// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final ValueChanged<String>? onsubmit;
  final ValueChanged? onchange;
  final GestureTapCallback? ontap;
  final FormFieldSetter<String>? onSaved;
  final bool isPassword;
  final FormFieldValidator validate;
  final String label;
  final IconData prefix;
  final IconData? suffix;
  final Function? suffixPressed;
  final List<String>? autofillHints;
  final bool isClickable;
  final bool isDetailedAddress;

  MyTextFormField({
    required this.controller,
    required this.type,
    required this.validate,
    required this.label,
    required this.prefix,
    this.onsubmit,
    this.onchange,
    this.ontap,
    this.onSaved,
    this.isPassword = false,
    this.suffix,
    this.suffixPressed,
    this.isClickable = true,
    this.isDetailedAddress = false,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onsubmit,
      onChanged: onchange,
      onTap: ontap,
      onSaved: onSaved,
      validator: validate,
      obscureText: isPassword,
      // expands: isDetailedAddress ?true:false,
      maxLines: isDetailedAddress ? 3 : 1,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(suffix),
              )
            : null,
      ),
    );
  }
}
