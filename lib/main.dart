import 'package:flutter/material.dart';
import 'package:trip_wallet/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Wallet',
      theme: ThemeData(
        primaryColor: Colors.white,
        hintColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.blue),
          titleTextStyle: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Trip Wallet'),
    );
  }
}
