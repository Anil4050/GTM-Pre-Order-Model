import 'package:flutter/material.dart';


ThemeData appTheme() {
return ThemeData(
useMaterial3: true,
colorSchemeSeed: Colors.green,
inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
);
}