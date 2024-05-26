import 'package:flutter/material.dart';

//General Spacing
const double kSpacing4 = 4.0;
const double kSpacing8 = 8.0;
const double kSpacing12 = 12.0;
const double kSpacing16 = 16.0;
const double kSpacing20 = 20.0;
const double kSpacing32 = 32.0;
const double kSpacing42 = 42.0;
const double kSpacing60 = 60.0;

//Corner Spacing
RoundedRectangleBorder kSpaceCorner8([BorderSide? border]) {
  return RoundedRectangleBorder(
    borderRadius: const BorderRadius.all(
      Radius.circular(kSpacing8),
    ),
    side: border ?? BorderSide.none,
  );
}
