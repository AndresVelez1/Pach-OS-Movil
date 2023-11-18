import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration inputDecoration(
      {required String hintext,
      required String labeltext,
      required Icon icono}) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFFC700)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFFC700), width: 2),
      ),
      hintText: hintext,
      labelText: labeltext,
      prefixIcon: icono,
    );
  }
}
