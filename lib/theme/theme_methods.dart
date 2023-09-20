import 'package:flutter/material.dart';

class ThemeMethods {
  const ThemeMethods._();

  static InputDecoration inputDecoration({
    required String labelText,
    String? hintText,
    bool isMultiline = false,
  }) =>
      InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 14,
          letterSpacing: .6,
          color: Colors.white60,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          letterSpacing: .6,
          color: Colors.white24,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.white30,
            width: .7,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.white30,
            width: .7,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.white70,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red.shade500,
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.white10,
            width: .7,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: isMultiline ? 16 : 0,
          horizontal: 16,
        ),
      );
}
