
import 'package:flutter/material.dart';

class ThemeColors{
  const ThemeColors._();

  static const primary = Color(0xff111518);
  static const secondary = Color(0xffcd3526);
  static const tertiary = Color(0xffffd19a);
  static const background = Color(0xff1c2121);

  static final darkTheme = ThemeData(
      fontFamily: 'Roboto',
      primaryColor: const Color(0xff1c2121),
      colorScheme: const ColorScheme.dark(
        background: background,
        primaryContainer: primary,
        secondaryContainer: secondary,
        tertiaryContainer: tertiary,

      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: tertiary,

      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
      )
  );
}

