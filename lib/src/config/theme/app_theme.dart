import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkmode;

  AppTheme({this.isDarkmode = false, this.selectedColor = 0})
    : assert(selectedColor >= 0, 'Selected color must be greater theme 0'),
      assert(
        selectedColor < colorList.length,
        'Selected color must be less or equal theme ${colorList.length - 1}',
      );

  ThemeData getTheme() => ThemeData(
    ///* General
    useMaterial3: true,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorList[selectedColor],

    ///* Texts
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 40, fontWeight: FontWeight.bold ),
      titleMedium: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 30, fontWeight: FontWeight.bold ),
      titleSmall: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 20 )
    ),

    ///* Scaffold Background Color
    // scaffoldBackgroundColor: scaffoldBackgroundColor,
    

    ///* Buttons
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.montserratAlternates()
            .copyWith(fontWeight: FontWeight.w700)
          )
      )
    ),

    ///* AppBar
    appBarTheme: AppBarTheme(
      centerTitle: false,
      // color: scaffoldBackgroundColor,
      titleTextStyle: GoogleFonts.montserratAlternates()
        .copyWith( fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black ),
    ),
  );

  AppTheme copyWith({int? selectedColor, bool? isDrakmode}) =>
      AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkmode: isDrakmode ?? isDarkmode,

      );
}
