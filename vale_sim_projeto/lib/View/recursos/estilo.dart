import 'package:flutter/material.dart';

ThemeData estilo() {
  ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Colors.indigo.shade900,
    colorScheme: ColorScheme.light(),
    textSelectionTheme: TextSelectionThemeData(cursorColor:  Color.fromARGB(255, 220, 183, 0)),
     
     //Botão flutuante
     floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor:  Color.fromARGB(255, 220, 183, 0),
      foregroundColor: Colors.white,
      hoverColor:  Color.fromARGB(255, 220, 183, 0),
     )
  );
}