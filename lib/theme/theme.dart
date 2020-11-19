import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application theme

const kLightSecondaryColor = Color(0xFFF3f7FB);
const kDarkSecondaryColor = Color(0xFFc26131);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kDarkPrimaryColor = Color(0xff27372b);
const kBackgroundLight = Color(0xFFF2F3F7);
const kBackgroundDark = Color(0xFF2A2A2A);
const kDividerLight = Color(0xFFFFFFFF);
const kAccentColor = Color(0xFFDB3D05);
const kTextLighter = Color(0xFFFBFBFB);
const kTextDarker = Color(0xFF17262A);
const kTextDark = Color(0xFF333333);
const kTextLight = Color(0xFFEEEEEE);
const kDarkColor = Color(0xFF000000);
const kIconDark = Color(0xFF666666);
const kOrange = Color(0xFFFB8C00);
const kLight = Color(0xFFFDFDFD);
const kDark = Color(0xFF333333);

final circularIndicator = CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation<Color>(kDarkSecondaryColor),
);

double height =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
double width =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

ThemeData get darkTheme {
  final base = ThemeData.dark();
  return base.copyWith(
    accentColor: kAccentColor,
    brightness: Brightness.dark,
    canvasColor: kDarkPrimaryColor,
    primaryColor: kLight,
    primaryColorLight: kDark,
    buttonColor: kDarkSecondaryColor,
    backgroundColor: kDarkSecondaryColor,
    cardColor: kDark,
    dividerColor: kDividerLight,
    scaffoldBackgroundColor: kBackgroundDark,
    toggleableActiveColor: kAccentColor,
    primaryIconTheme: base.iconTheme.copyWith(color: kIconDark),
    buttonTheme: base.buttonTheme.copyWith(buttonColor: kDarkSecondaryColor),
    cardTheme: base.cardTheme.copyWith(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    textTheme: _buildTextTheme(base.textTheme, kTextLight, kTextLighter),
    primaryTextTheme:
        _buildTextTheme(base.primaryTextTheme, kTextLight, kTextLighter),
    accentTextTheme:
        _buildTextTheme(base.accentTextTheme, kTextLight, kTextLighter),
    snackBarTheme: base.snackBarTheme.copyWith(
      backgroundColor: kDark,
      contentTextStyle: base.textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        color: kTextLight,
      ),
    ),
    appBarTheme: base.appBarTheme
        .copyWith(brightness: Brightness.dark, color: kDark, elevation: 4),
    iconTheme: base.iconTheme.copyWith(color: kAccentColor),
    dialogTheme: base.dialogTheme.copyWith(
      contentTextStyle: TextStyle(color: kDarkColor),
      backgroundColor: kDarkPrimaryColor,
    ),
  );
}

ThemeData get theme {
  final base = ThemeData.light();
  return base.copyWith(
    accentColor: kAccentColor,
    // dividerTheme: DividerThemeData(
    //     space: 0.08.hp, endIndent: 0.042.hp, indent: 0.042.hp, thickness: 1.w),
    brightness: Brightness.light,
    buttonColor: kAccentColor,
    buttonTheme: base.buttonTheme.copyWith(buttonColor: kAccentColor),
    canvasColor: kLightPrimaryColor,
    primaryColor: kDark,
    cardColor: kLightPrimaryColor,
    primaryColorLight: kLightPrimaryColor,
    backgroundColor: kLightSecondaryColor,
    scaffoldBackgroundColor: kBackgroundLight,
    primaryIconTheme: base.iconTheme.copyWith(color: kIconDark),
    toggleableActiveColor: kOrange,
    cardTheme: base.cardTheme.copyWith(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    dialogTheme: base.dialogTheme.copyWith(
      contentTextStyle: TextStyle(color: kDarkColor),
    ),
    appBarTheme: base.appBarTheme
        .copyWith(brightness: Brightness.light, color: kLight, elevation: 4),
    iconTheme: base.iconTheme.copyWith(color: kAccentColor),
    primaryTextTheme:
        _buildTextTheme(base.primaryTextTheme, kTextDark, kTextDarker),
    accentTextTheme:
        _buildTextTheme(base.accentTextTheme, kTextDark, kTextDarker),
    textTheme: _buildTextTheme(base.textTheme, kTextDark, kTextDark),
    snackBarTheme: base.snackBarTheme.copyWith(
      backgroundColor: kLight,
      contentTextStyle: base.textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        color: kTextDark,
      ),
    ),
  );
}

TextTheme _buildTextTheme(TextTheme base, Color displayColor, Color bodyColor) {
  return GoogleFonts.rubikTextTheme()
      .copyWith(
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          fontSize: 20,
        ),
        headline6: base.headline6.copyWith(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          fontSize: 20,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
        subtitle1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(displayColor: displayColor, bodyColor: bodyColor);
}
