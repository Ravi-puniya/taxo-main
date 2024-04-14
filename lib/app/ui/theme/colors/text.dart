import 'package:flutter/material.dart';

const MaterialColor textColor = MaterialColor(
  _textcolorPrimaryValue,
  <int, Color>{
    50: Color(0xFFE4E4E4),
    100: Color(0xFFBCBCBC),
    200: Color(0xFF8F8F8F),
    300: Color(0xFF626262),
    400: Color(0xFF414141),
    500: Color(_textcolorPrimaryValue),
    600: Color(0xFF1B1B1B),
    700: Color(0xFF171717),
    800: Color(0xFF121212),
    900: Color(0xFF0A0A0A),
  },
);

const int _textcolorPrimaryValue = 0xFF1F1F1F;

const MaterialColor textColorAccent = MaterialColor(
  _textcolorAccentValue,
  <int, Color>{
    100: Color(0xFFE07171),
    200: Color(_textcolorAccentValue),
    400: Color(0xFFEB0000),
    700: Color(0xFFD10000),
  },
);

const int _textcolorAccentValue = 0xFFD74747;
