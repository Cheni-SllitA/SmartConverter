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

    // // Technology related unit categories
    // 'Data Storage': ['Bits', 'Bytes', 'Kilobytes', 'Megabytes', 'Gigabytes', 'Terabytes', 'Petabytes'],
    // 'Network Speed': ['Bits per Second (bps)', 'Kilobits per Second (Kbps)', 'Megabits per Second (Mbps)', 'Gigabits per Second (Gbps)', 'Terabits per Second (Tbps)', 'Bytes per Second (Bps)', 'Megabytes per Second (MBps)'],
    // 'Number System': ['Binary', 'Octal', 'Decimal', 'Hexadecimal', 'Duodecimal', 'Base-32', 'Base-64'],

    // //Scientific unit categories
    // 'Energy': ['Joules', 'Calories', 'Kilocalories', 'Kilowatt-hours', 'BTU', 'Electronvolts'],
    // 'Power': ['Watts', 'Kilowatts', 'Megawatts', 'Horsepower', 'BTU/Hour'],
    // 'Frequency': ['Hertz', 'Kilohertz', 'Megahertz', 'Gigahertz', 'Terahertz'],
    // 'Angle': ['Degrees', 'Radians', 'Gradians', 'Turns', 'Arcminutes', 'Arcseconds'],
    // 'Force': ['Newtons', 'Pounds-force', 'Kilograms-force', 'Dynes', 'Kilonewtons'],
    // 'Illuminance': ['Lux', 'Foot-candles', 'Phot', 'Nits'],
    // 'Sound Level': ['Decibels', 'Phons', 'Sones', 'Nepers'],
    // 'Torque': ['Newton-meters', 'Pound-feet', 'Kilogram-meters', 'Dyne-centimeters'],
    // 'Luminance': ['Candela/Square Meter', 'Foot-lamberts', 'Nits'],
    // 'Density': ['Kilograms/Cubic Meter', 'Grams/Cubic Centimeter', 'Pounds/Cubic Foot'],
    // 'Voltage': ['Volts', 'Millivolts', 'Kilovolts'],
    // 'Resistance': ['Ohms', 'Kiloohms', 'Megaohms'],
    // 'Capacitance': ['Farads', 'Microfarads', 'Nanofarads', 'Picofarads'],
    // 'Inductance': ['Henrys', 'Millihenrys', 'Microhenrys'],
    // 'Magnetic Flux': ['Weber', 'Maxwell'],
    // 'Magnetic Field Strength': ['Tesla', 'Gauss'],
    // 'Radiation Dose': ['Gray', 'Sievert', 'Rad', 'Rem'],
    // 'Radioactivity': ['Becquerel', 'Curie'],
    // 'Luminous Flux': ['Lumens', 'Candela', 'Foot-lamberts'],
    // 'Acceleration': ['Meters/Second²', 'Feet/Second²', 'G-force']
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
