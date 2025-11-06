import 'package:flutter/material.dart';
import 'unit_converter_screen.dart';
import 'currency_converter_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    UnitConverterScreen(),
    CurrencyConverterScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Converter')),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.straighten), label: 'Units'),
          BottomNavigationBarItem(icon: Icon(Icons.currency_exchange), label: 'Currency'),
        ],
      ),
    );
  }
}
