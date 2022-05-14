import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'TitilliumWeb',
  // primaryColor: Color(0xFF1B7FED),
  primaryColor: Color(0xFF1E1C66),
  brightness: Brightness.light,
  highlightColor: Colors.white,
  // hintColor: Color(0xFF9E9E9E),
  hintColor: Colors.blueAccent,
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);