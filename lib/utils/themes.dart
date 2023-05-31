import 'package:flutter/material.dart';

const cpBlack = Color.fromARGB(255, 33, 33, 33);
const cpWhite = Color.fromARGB(255, 250, 250, 250);
const cpGreen = Color.fromRGBO(126, 207, 126, 1);
const cpGreenDark = Color.fromRGBO(73, 113, 73, 1);
const cpGrey = Color.fromARGB(255, 158, 158, 158);
const dividerColor = Color.fromARGB(255, 244, 244, 244);
const moreInfoBroderColor = Color.fromARGB(255, 158, 158, 158);

const largeTextStyle = TextStyle(
  inherit: false,
  fontFamily: 'Nunito',
  fontWeight: FontWeight.w700,
);

const mediumTextStyle = TextStyle(
  inherit: false,
  fontFamily: 'Nunito',
  fontWeight: FontWeight.w600,
);

const smallTextStyle = TextStyle(
  inherit: false,
  fontFamily: 'Nunito',
  fontWeight: FontWeight.w400,
  fontSize: 18,
);

ColorScheme darkColorScheme = const ColorScheme.dark(
  primary: cpGreenDark,
  surface: cpGreenDark,
);
ColorScheme lightColorScheme = const ColorScheme.light(primary: cpGreen);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  shadowColor: Colors.black,
  hintColor: const Color.fromARGB(255, 66, 66, 66),
  textTheme: TextTheme(
    displayLarge: largeTextStyle.copyWith(color: cpWhite),
    displayMedium: mediumTextStyle.copyWith(color: cpWhite),
    bodyLarge: smallTextStyle.copyWith(color: cpWhite),
  ),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  shadowColor: const Color.fromARGB(127, 97, 86, 84),
  hintColor: const Color.fromARGB(255, 210, 210, 210),
  textTheme: TextTheme(
    displayLarge: largeTextStyle.copyWith(color: cpBlack),
    displayMedium: mediumTextStyle.copyWith(color: cpBlack),
    bodyLarge: smallTextStyle.copyWith(color: cpBlack),
  ),
);
