import 'package:flutter/material.dart';
import 'package:expence_tracker/widgets/expenses.dart';
import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
var kdarkScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 32, 193, 238));

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //   .then((fn) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kdarkScheme,
        cardTheme: const CardTheme().copyWith(
            color: kdarkScheme.onSecondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shadowColor: Colors.blueAccent),
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kdarkScheme.onPrimaryContainer,
          foregroundColor: kdarkScheme.primaryContainer,
        ),
      ),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: kColorScheme.onSecondaryContainer))),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
  //});
}
