import 'package:flutter/material.dart';
import 'package:rankgroupassignment/app/palette.dart';
import 'package:rankgroupassignment/app/formatting.dart';

ThemeData getAppTheme() {
  return ThemeData(
    iconTheme: const IconThemeData(
      size: kSpacing42,
      color: colourBlack,
    ),
    canvasColor: colourWhite,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colourRankBluePrimary,
      brightness: Brightness.light,
    ),
    cardColor: colourRankGreyLight,
    cardTheme: const CardTheme(
      color: colourRankGreyLight, // Titles
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kSpacing4),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return colourRankGreyShade;
            }
            return colourRankBluePrimary;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            return colourWhite;
          },
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          (Set<MaterialState> states) {
            return const TextStyle(
              fontSize: kSpacing16,
            );
          },
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kSpacing4),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            return colourWhite;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            return colourRankBluePrimary;
          },
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          (Set<MaterialState> states) {
            return const TextStyle(
              fontSize: kSpacing16,
            );
          },
        ),
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: colourWhite,
      iconColor: colourRankRedPrimary,
      surfaceTintColor: Colors.transparent,
    ),
    useMaterial3: true,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: kSpacing20,
        fontWeight: FontWeight.bold,
      ),
      displayLarge: TextStyle(
        fontSize: kSpacing16,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        fontSize: kSpacing12,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: colourBlack,
      selectedItemColor: colourRankBluePrimary,
    ),
  );
}
