import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() => ThemeData(
    primarySwatch: Colors.deepPurple,
    useMaterial3: false,
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}
