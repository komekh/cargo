import 'package:flutter/material.dart';

class Keyboard {
  static hide(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
