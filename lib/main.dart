import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:list_show/screens/data_list.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  surface: const Color.fromARGB(255, 242, 240, 245),
  seedColor: const Color.fromARGB(255, 51, 70, 106),
);

final themeData = ThemeData().copyWith(
    scaffoldBackgroundColor: colorScheme.surface,
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
      home: DataTablePaginationExample(),
    );
  }
}
