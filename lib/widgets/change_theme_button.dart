import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

Widget changeThemeButton(context) {
  return IconButton(
    icon: Icon(Icons.brightness_6),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    color: Colors.white,
    onPressed: () {
      DynamicTheme.of(context).setBrightness(
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark);
      print('Current Brightness: ${Theme.of(context).brightness}');
    },
  );
}
