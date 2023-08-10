import 'package:flutter/material.dart';

class TextFieldDecorations{

    InputDecoration inputDecorationStyle(
      BuildContext context, String title, String hinttext) {
    return InputDecoration(
      labelText: title,
      labelStyle: const TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(7.0),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      filled: true,
      hintText: hinttext,
    );
  }


}