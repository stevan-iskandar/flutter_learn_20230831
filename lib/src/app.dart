import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_learn_20230831/src/constants/env.dart';
import 'package:flutter_learn_20230831/src/widgets/grocery_list.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData theme({
    required Brightness brightness,
  }) {
    return ThemeData(
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: const Color.fromARGB(255, 147, 229, 250),
      ),
      textTheme: GoogleFonts.montserratTextTheme(),
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(brightness: Brightness.light),
      darkTheme: theme(brightness: Brightness.dark),
      debugShowCheckedModeBanner:
          dotenv.env[Env.debug]?.toLowerCase() == 'true',
      home: const GroceryList(),
    );
  }
}
