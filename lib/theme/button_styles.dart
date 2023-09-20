import 'package:flutter/material.dart';

class ButtonStyles{
  const ButtonStyles._();

  static ButtonStyle popUpActionButtonStyle = ElevatedButton.styleFrom(
    visualDensity: VisualDensity.compact,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    backgroundColor: Colors.white.withOpacity(.8),
  );


}
