import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:list_show/screens/show_list_data.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  surface: const Color.fromARGB(255, 24, 22, 27),
  seedColor: const Color.fromARGB(255, 28, 32, 39),
);

final themeData = ThemeData().copyWith(
    colorScheme: colorScheme,
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      titleLarge: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
    ));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      home: const ShowListData(),
    );
  }
}
