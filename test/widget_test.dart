// Smoke tests for the Smart Converter app shell.
//
// These cover the parts of the UI that don't depend on network access: the
// app builds, the navigation shell renders, and switching tabs swaps the
// visible converter screen.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smart_converter/main.dart';
import 'package:smart_converter/screens/computer_unit_converter_screen.dart';

void main() {
  testWidgets('app builds and shows the converter shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SmartConverterApp());

    // The navigation shell and its swipeable page area are present.
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);

    // The first tab is selected, so its title is in the app bar.
    expect(find.text('Unit Converter'), findsWidgets);
  });

  testWidgets('bottom navigation exposes all four converters', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SmartConverterApp());

    final navBar = tester.widget<NavigationBar>(find.byType(NavigationBar));
    expect(navBar.destinations, hasLength(4));
    expect(navBar.selectedIndex, 0);

    for (final label in ['Unit', 'Currency', 'Computer', 'Scientific']) {
      expect(find.text(label), findsOneWidget);
    }
  });

  testWidgets('tapping a destination switches the visible screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SmartConverterApp());

    await tester.tap(find.text('Computer'));
    // Let the page animation (300ms) run to completion.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    final navBar = tester.widget<NavigationBar>(find.byType(NavigationBar));
    expect(navBar.selectedIndex, 2);
    expect(find.byType(ComputerUnitConverterScreen), findsOneWidget);
  });
}
