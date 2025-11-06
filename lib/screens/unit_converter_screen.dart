import 'package:flutter/material.dart';

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _fromUnit = 'Meters';
  String _toUnit = 'Kilometers';
  double? _result;

  final Map<String, double> conversionRates = {
    'Meters': 1.0,
    'Kilometers': 0.001,
    'Centimeters': 100.0,
  };

  void _convert() {
    double input = double.tryParse(_controller.text) ?? 0;
    double baseValue = input / conversionRates[_fromUnit]!;
    double convertedValue = baseValue * conversionRates[_toUnit]!;
    setState(() => _result = convertedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Enter value'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: _fromUnit,
                items: conversionRates.keys.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                onChanged: (val) => setState(() => _fromUnit = val!),
              ),
              const Icon(Icons.arrow_forward),
              DropdownButton<String>(
                value: _toUnit,
                items: conversionRates.keys.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                onChanged: (val) => setState(() => _toUnit = val!),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _convert, child: const Text('Convert')),
          const SizedBox(height: 20),
          if (_result != null)
            Text(
              'Result: $_result $_toUnit',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
