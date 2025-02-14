import 'package:flutter/material.dart';

// Themes

// ! Colors
const Color lightMaroon = Color.fromARGB(255, 135, 36, 52);
const Color bloodRed = Color.fromARGB(255, 128, 21, 32);
const Color deepMaroon = Color.fromARGB(255, 71, 8, 15);

const Color offWhite = Color.fromARGB(255, 227, 227, 227);
const Color offWhiteSemiClear = Color.fromARGB(152, 227, 227, 227);
const Color lightGray = Color.fromARGB(255, 102, 108, 108);
const Color deepGray = Color.fromARGB(255, 62, 62, 62);
const Color darkGray = Color.fromARGB(255, 50, 50, 50);
const Color softBlack = Color.fromARGB(255, 27, 27, 27);

const Color clickableBlue = Color.fromARGB(255, 43, 153, 255);

const Color deepMagenta = Color.fromARGB(255, 104, 23, 95);

// ! Usable colors
const Color primary = bloodRed;
const Color onPrimary = deepMaroon;

const Color secondary = lightGray;
const Color onSecondary = darkGray;

const Color tertiary = deepMagenta;

const Color background = deepGray;

const Color textColor = offWhite;
const Color hintColor = offWhiteSemiClear;
const Color iconColor = offWhite;

const textStyle = TextStyle(
  color: textColor,
  fontSize: 16,
);

final titleStyle = textStyle.copyWith(
    // Difference to make this a title
    );

// different sizes of titleStyle
final titleStyleLarge = titleStyle.copyWith(
  fontSize: 36,
);
final titleStyleMedium = titleStyle.copyWith(
  fontSize: 28,
);
final titleStyleSmall = titleStyle.copyWith(
  fontSize: 22,
);

final textStyleLarge = textStyle.copyWith(
  fontSize: 20,
);
final textStyleMedium = textStyle.copyWith(
    // this is just here for formatting reasons
    // this TextStyle is no different than textStyle
    );
final textStyleSmall = textStyle.copyWith(
  fontSize: 12,
);

final hintStyleLarge = textStyleLarge.copyWith(
  color: hintColor,
);
final hintStyleMedium = textStyleMedium.copyWith(
  color: hintColor,
);
final hintStyleSmall = textStyleSmall.copyWith(
  color: hintColor,
);

final clickableStyleLarge = textStyleLarge.copyWith(
  color: clickableBlue,
);
final clickableStyleMedium = textStyleMedium.copyWith(
  color: clickableBlue,
);
final clickableStyleSmall = textStyleSmall.copyWith(
  color: clickableBlue,
);

ThemeData petwiseTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(255, 255, 255, 255),
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 255, 255, 255)),
    iconTheme: const IconThemeData(
      color: iconColor,
    ),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
      iconColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 255, 255, 255)),
    )));
