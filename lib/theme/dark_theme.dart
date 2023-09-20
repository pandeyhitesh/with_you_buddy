
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xff1c2121),
  colorScheme: const ColorScheme.dark(
    background: Color(0xff1c2121),
    primaryContainer: Color(0xff111518),
    secondaryContainer: Color(0xffcd3526),
    tertiaryContainer: Color(0xffffd19a),

  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.white.withOpacity(.9),

  )
);