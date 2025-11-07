import 'package:flutter/material.dart';
import '../services/conversion_service.dart';

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _category = 'Length';
  String _fromUnit = 'Meters';
  String _toUnit = 'Kilometers';
  double? _result;

  final Map<String, List<String>> unitCategories = {

    // Common unit categories and their units
    'Length': ['Meters', 'Kilometers', 'Centimeters', 'Miles', 'Feet', 'Inches', 'Yards', 'Millimeters'],
    'Weight': ['Kilograms', 'Grams', 'Pounds', 'Ounces', 'Milligrams', 'Stones', 'Tons'],
    'Temperature': ['Celsius', 'Fahrenheit', 'Kelvin', 'Rankine'],
    'Area': ['Square Meters', 'Square Kilometers', 'Square Feet', 'Acres', 'Square Miles', 'Hectares', 'Square Inches'],
    'Volume': ['Liters', 'Milliliters', 'Cubic Meters', 'Cubic Feet', 'Gallons', 'Quarts', 'Pints'],
    'Pressure': ['Pascals', 'Bar', 'PSI', 'Atmospheres', 'Torr', 'mmHg'],
    'Time': ['Seconds', 'Minutes', 'Hours', 'Days', 'Weeks', 'Months', 'Years'],
    'Speed': ['Meters/Second', 'Kilometers/Hour', 'Miles/Hour', 'Knots', 'Feet/Second', 'Mach'],
    'Fuel Consumption': ['Liters/100km', 'Miles/Gallon (US)', 'Miles/Gallon (UK)', 'Kilometers/Liter'],
    'Electrical Current': ['Amperes', 'Milliamperes', 'Microamperes', 'Kiloamperes'],
  };

  void _convert() {
    final input = double.tryParse(_controller.text) ?? 0;
    double convertedValue = 0;

    switch (_category) {
      case 'Length':
        convertedValue = ConversionService.convertLength(input, _fromUnit, _toUnit);
        break;
      case 'Weight':
        convertedValue = ConversionService.convertWeight(input, _fromUnit, _toUnit);
        break;
      case 'Temperature':
        convertedValue = ConversionService.convertTemperature(input, _fromUnit, _toUnit);
        break;
      
      case 'Area':
        convertedValue = ConversionService.convertArea(input, _fromUnit, _toUnit);
        break;
      case 'Volume':
        convertedValue = ConversionService.convertVolume(input, _fromUnit, _toUnit);
        break;
      case 'Pressure':
        convertedValue = ConversionService.convertPressure(input, _fromUnit, _toUnit);
        break;
      case 'Time':
        convertedValue = ConversionService.convertTime(input, _fromUnit, _toUnit);
        break;
      
      case 'Speed':
        convertedValue = ConversionService.convertSpeed(input, _fromUnit, _toUnit);
        break;
      case 'Fuel Consumption':
        convertedValue = ConversionService.convertFuelConsumption(input, _fromUnit, _toUnit);
        break;
      case 'Electrical Current':
        convertedValue = ConversionService.convertElectricalCurrent(input, _fromUnit, _toUnit);
        break;
    }

    setState(() => _result = convertedValue);
  }

  void _onCategoryChange(String newCategory) {
    setState(() {
      _category = newCategory;
      _fromUnit = unitCategories[newCategory]!.first;
      _toUnit = unitCategories[newCategory]!.last;
      _result = null;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownButton<String>(
            value: _category,
            items: unitCategories.keys
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (val) => _onCategoryChange(val!),
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Enter value'),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: _fromUnit,
                items: unitCategories[_category]!
                    .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                    .toList(),
                onChanged: (val) => setState(() => _fromUnit = val!),
              ),
              const Icon(Icons.arrow_forward),
              DropdownButton<String>(
                value: _toUnit,
                items: unitCategories[_category]!
                    .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                    .toList(),
                onChanged: (val) => setState(() => _toUnit = val!),
              ),
            ],
          ),
          const SizedBox(height: 25),

          ElevatedButton(onPressed: _convert, child: const Text('Convert')),
          const SizedBox(height: 25),

          if (_result != null)
            Text(
              'Result: ${_result!.toStringAsFixed(2)} $_toUnit',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}

