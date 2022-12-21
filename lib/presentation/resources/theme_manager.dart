import 'package:flutter/material.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/style_manager.dart';
import 'package:flutter_application_udemy_mvvm/presentation/resources/value_manager.dart';

import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
//main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    accentColor: ColorManager.grey,
    //ripple color
    splashColor: ColorManager.primaryOpacity70,

//card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

//App bar theme

    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s16,
      ),
    ),
//Button theme
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),
//elevated button theme

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
        ),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s4),
        ),
      ),
    ),
//Text theme
    textTheme: TextTheme(
      headline1: getsemiBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      subtitle1: getmediumStyle(
        color: ColorManager.lightdrey,
        fontSize: FontSize.s14,
      ),
      subtitle2: getmediumStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
      caption: getRegularStyle(
        color: ColorManager.grey,
      ),
      bodyText1: getRegularStyle(
        color: ColorManager.grey,
      ),
    ),
//input decoration theme(test form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppPadding.p8),
      //hint style

      hintStyle: getRegularStyle(
        color: ColorManager.grey,
      ),
      labelStyle: getmediumStyle(
        color: ColorManager.grey,
      ),
      //error style
      errorStyle: getRegularStyle(
        color: ColorManager.error,
      ),
//enabled boreder

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),

      //focus border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
//error border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
  );
}
