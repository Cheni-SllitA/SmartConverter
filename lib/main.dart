import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SmartConverterApp());
}

class SmartConverterApp extends StatelessWidget {
  const SmartConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Converter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
