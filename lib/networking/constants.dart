import 'package:flutter/material.dart';

class CustomColors {
  static const backgroundColor = [Color(0xffbdc3c7), Color(0xff2c3e50)];
  static const buttonShadowColor = [Color(0xffffd89b), Color(0xff19547b)];
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension NameValidator on String {
  bool isValidName() {
    return RegExp(r"^[a-zA-Z]+$").hasMatch(this);
  }
}

extension MobileNoValidator on String {
  bool isValidPhone() {
    return RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)").hasMatch(this);
  }
}
