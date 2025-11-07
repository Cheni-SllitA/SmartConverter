import 'package:flutter/material.dart';
import 'unit_converter_screen.dart';
import 'currency_converter_screen.dart';
import 'computer_unit_converter_screen.dart';
import 'scientific_unit_converter_screen.dart';

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
    ComputerUnitConverterScreen(),
    ScientificUnitConverterScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Converter'),
        centerTitle: true,
      ),
      body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.straighten), label: 'Units'),
          BottomNavigationBarItem(icon: Icon(Icons.currency_exchange), label: 'Currency'),
          BottomNavigationBarItem(icon: Icon(Icons.computer), label: 'Computer'),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Scientific'),
        ],
      ),
    );
  }
}

