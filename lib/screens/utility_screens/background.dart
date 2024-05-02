// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget background_body({required Widget child}) {
  return Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          "assets/background.jpg",
          fit: BoxFit.cover,
        ),
      ),
      child,
    ],
  );
}
