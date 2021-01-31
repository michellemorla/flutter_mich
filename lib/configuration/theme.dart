import 'package:flutter/material.dart';
import 'package:flutter_mich/configuration/app_colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  canvasColor: AppColors.lightBackground,
  cardColor: AppColors.lightBackground,
  accentColor: AppColors.accentColor,
  brightness: Brightness.light,
  highlightColor: AppColors.transparent,
  splashColor: AppColors.transparent,
  backgroundColor: AppColors.lightBackground,
  scaffoldBackgroundColor: AppColors.lightBackground,
  textSelectionColor: AppColors.primaryColor,
  textSelectionHandleColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(
    brightness: Brightness.light
  ),
  colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
);

final ThemeData appThemeDark = ThemeData(
  primaryColor: AppColors.primaryColor,
  canvasColor: AppColors.darkBackground,
  cardColor: AppColors.darkBackground,
  accentColor: AppColors.accentColor,
  brightness: Brightness.dark,
  highlightColor: AppColors.transparent,
  splashColor: AppColors.transparent,
  backgroundColor: AppColors.darkBackground,
  scaffoldBackgroundColor: AppColors.darkBackground,
  textSelectionColor: AppColors.primaryColor,
  textSelectionHandleColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(
      brightness: Brightness.dark
  ),
  colorScheme: ColorScheme.dark(primary: AppColors.primaryColor),
);