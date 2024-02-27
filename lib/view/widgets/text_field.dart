import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  String labelText;
  TextEditingController controller;
  TextInputType textInputType;
  MyTextFields({
    super.key,
    required this.labelText,
    required this.controller,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding:const EdgeInsets.all(16),
          labelText: labelText,
          focusColor: Colors.black,
          floatingLabelStyle:const TextStyle(color: Colors.grey),
          labelStyle: const TextStyle(
              fontSize: 16, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:const BorderSide(
              color: Colors.black,
            ),
          )),
      keyboardType: textInputType,
    );
  }
}
