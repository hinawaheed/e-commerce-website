import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
   fillColor: Colors.white,
   filled: true,
   enabledBorder: OutlineInputBorder(
     borderSide: BorderSide(color: Colors.black, width: 2.0)
   ),
   focusedBorder: OutlineInputBorder(
     borderSide: BorderSide(color: Colors.grey, width: 2.0)
   ),
  );

  class AppColors {
  static const mainColor = Color(0XFFe5eefc);
  static const styleColor = Color(0XFF6f7e96);
  static const activeColor = Color(0XFFd0ddf3);
  static const lightBlue = Color(0XFF92aeff);
  static const darkBlue = Color(0XFF5880ff);
  static const lightBlueShadow = Color(0XAA92aeff);
}
