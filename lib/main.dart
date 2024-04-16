import 'package:untitled36/screens/permissions_screen.dart';

import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(128, 192, 56, 1),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
void main() {
  runApp(
    MaterialApp(
      title: "Call Logs",
      home: const PermissionsScreen(),
    ),
  );
}