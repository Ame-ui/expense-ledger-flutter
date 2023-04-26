import 'package:expense_ledger/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light().copyWith(
      primary: MyColors.primaryColor,
      shadow: Colors.black.withOpacity(0.1),
    ),
    primaryColor: MyColors.primaryColor,
    appBarTheme: const AppBarTheme(
      foregroundColor: MyColors.secondaryTxtColor,
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    scaffoldBackgroundColor: MyColors.backgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: MyColors.primaryColor, foregroundColor: Colors.white),
    hintColor: MyColors.greyColor,
    iconTheme: const IconThemeData(color: MyColors.secondaryTxtColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(MyColors.primaryColor),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    ),
    radioTheme: const RadioThemeData(
      fillColor: MaterialStatePropertyAll(MyColors.primaryColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      backgroundColor: Colors.white,
      elevation: 1,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: MyColors.primaryColor,
      unselectedItemColor: MyColors.inactiveColor,
      selectedIconTheme: const IconThemeData(size: 20),
      unselectedIconTheme: const IconThemeData(size: 20),
      selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w400),
      unselectedLabelStyle: TextStyle(
          color: MyColors.greyColor,
          fontSize: 10,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w500),
      type: BottomNavigationBarType.fixed,
    ),
    shadowColor: Colors.black.withOpacity(0.1),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          TextStyle(
              color: MyColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.poppins().fontFamily),
        ),
      ),
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: MyColors.primaryColor,
      unselectedLabelColor: MyColors.greyColor,
    ),
    textTheme: TextTheme(
      // text with primary txt color
      bodyLarge: TextStyle(
          color: MyColors.primaryTxtColor,
          fontSize: 16,
          fontFamily: GoogleFonts.poppins().fontFamily),
      // text with secondary txt color
      bodyMedium: TextStyle(
          color: MyColors.secondaryTxtColor,
          fontSize: 16,
          fontFamily: GoogleFonts.poppins().fontFamily),
      // text with grey color
      bodySmall: TextStyle(
          color: MyColors.greyColor,
          fontSize: 16,
          fontFamily: GoogleFonts.poppins().fontFamily),
      // text with white color
      titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: GoogleFonts.poppins().fontFamily),

      // text with primary color
      titleMedium: TextStyle(
          color: MyColors.primaryColor,
          fontSize: 16,
          fontFamily: GoogleFonts.poppins().fontFamily),
      //
      // displayLarge: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // displaySmall: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // // button: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // displayMedium: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // caption: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // headline1: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // headline2: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // headline3: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // headline4: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // headline5: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // headline6: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // headlineLarge: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // headlineMedium: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // headlineSmall: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // labelLarge: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // labelMedium: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // labelSmall: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // overline: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // subtitle1: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // subtitle2: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // titleLarge: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // titleMedium: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      // titleSmall: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
    ),
    dividerTheme: const DividerThemeData(
        color: MyColors.inactiveColor, thickness: 0.5, space: 20),
  );
}
