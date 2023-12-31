import 'package:app_store/src/themes/color_schemes.g.dart';
import 'package:flutter/material.dart';

ThemeData get lightTheme => _lightTheme;
ThemeData get darkTheme => _darkTheme;


ThemeData _lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 3,
    shadowColor: lightColorScheme.onPrimary,
  )
);

ThemeData _darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme2,
  appBarTheme: const AppBarTheme(
    elevation: 0,
  )
);