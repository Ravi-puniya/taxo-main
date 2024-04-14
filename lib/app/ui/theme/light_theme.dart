import 'package:flutter/material.dart';

import 'package:facturadorpro/app/ui/theme/colors/primary.dart';

final ThemeData appThemeData = ThemeData(
  primarySwatch: primaryColor,
  primaryColorLight: primaryColor.shade400,
  primaryColor: primaryColor,
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);
