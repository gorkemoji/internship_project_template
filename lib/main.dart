import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_project_template/view/screen/splash_screen.dart';

import 'constant/application_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hilingo',
      theme: ThemeData(
        textTheme: GoogleFonts.urbanistTextTheme(
          Theme.of(context).textTheme
        ),
        colorScheme: .fromSeed(seedColor: ApplicationColors.accent),
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.transparent,
        )
      ),
      home: const SplashScreen()
    );
  }
}
