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
  final PageController _pageController = PageController();

  // Using const for screens that don't need to be recreated
  static const List<Widget> _screens = [
    UnitConverterScreen(),
    CurrencyConverterScreen(),
    ComputerUnitConverterScreen(),
    ScientificUnitConverterScreen(),
  ];

  // Screen metadata for better UI
  static const List<_ScreenInfo> _screenInfo = [
    _ScreenInfo(
      title: 'Unit Converter',
      icon: Icons.straighten_rounded,
      gradient: [Color(0xFF667eea), Color(0xFF764ba2)],
    ),
    _ScreenInfo(
      title: 'Currency',
      icon: Icons.currency_exchange_rounded,
      gradient: [Color(0xFF00B4DB), Color(0xFF0083B0)],
    ),
    _ScreenInfo(
      title: 'Computer',
      icon: Icons.computer_rounded,
      gradient: [Color(0xFF11998e), Color(0xFF38ef7d)],
    ),
    _ScreenInfo(
      title: 'Scientific',
      icon: Icons.science_rounded,
      gradient: [Color(0xFFf093fb), Color(0xFFf5576c)],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // Modern app bar with gradient
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _screenInfo[_selectedIndex].gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _screenInfo[_selectedIndex].icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              _screenInfo[_selectedIndex].title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
      // PageView for smooth swiping between screens
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens,
      ),
      // Modern bottom navigation bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          backgroundColor: colorScheme.surface,
          indicatorColor: colorScheme.primaryContainer,
          height: 70,
          elevation: 0,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          animationDuration: const Duration(milliseconds: 400),
          destinations: _screenInfo.map((info) {
            final isSelected = _screenInfo[_selectedIndex] == info;
            return NavigationDestination(
              icon: Icon(info.icon),
              selectedIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: info.gradient,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  info.icon,
                  color: Colors.white,
                ),
              ),
              label: info.title.split(' ').first,
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Helper class for screen metadata
class _ScreenInfo {
  final String title;
  final IconData icon;
  final List<Color> gradient;

  const _ScreenInfo({
    required this.title,
    required this.icon,
    required this.gradient,
  });
}