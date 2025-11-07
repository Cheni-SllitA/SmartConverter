import 'package:flutter/material.dart';
import '../services/conversion_service.dart';

//ComputerUnitConverterScreen

class ScientificUnitConverterScreen extends StatefulWidget {
  const ScientificUnitConverterScreen({super.key});

  @override
  State<ScientificUnitConverterScreen> createState() => _ScientificUnitConverterScreenState();
}

class _ScientificUnitConverterScreenState extends State<ScientificUnitConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _category = 'Energy';
  String _fromUnit = 'Joules';
  String _toUnit = 'Calories';
  double? _result;

  final Map<String, List<String>> unitCategories = {
        //Scientific unit categories
    'Energy': ['Joules', 'Calories', 'Kilocalories', 'Kilowatt-hours', 'BTU', 'Electronvolts'],
    'Power': ['Watts', 'Kilowatts', 'Megawatts', 'Horsepower', 'BTU/Hour'],
    'Frequency': ['Hertz', 'Kilohertz', 'Megahertz', 'Gigahertz', 'Terahertz'],
    'Angle': ['Degrees', 'Radians', 'Gradians', 'Turns', 'Arcminutes', 'Arcseconds'],
    'Force': ['Newtons', 'Pounds-force', 'Kilograms-force', 'Dynes', 'Kilonewtons'],
    'Illuminance': ['Lux', 'Foot-candles', 'Phot', 'Nits'],
    'Sound Level': ['Decibels', 'Phons', 'Sones', 'Nepers'],
    'Torque': ['Nm', 'Lb-ft', 'Kilogram-meters', 'dyncm'],
    'Luminance': ['Candela/m³', 'Foot-lamberts', 'Nits'],
    'Density': ['kg/m³', 'G/cc', 'lb/ft³'],
    'Voltage': ['Volts', 'Millivolts', 'Kilovolts'],
    'Resistance': ['Ohms', 'Kiloohms', 'Megaohms'],
    'Capacitance': ['Farads', 'Microfarads', 'Nanofarads', 'Picofarads'],
    'Inductance': ['Henrys', 'Millihenrys', 'Microhenrys'],
    'Magnetic Flux': ['Weber', 'Maxwell'],
    'Magnetic Field Strength': ['Tesla', 'Gauss'],
    'Radiation Dose': ['Gray', 'Sievert', 'Rad', 'Rem'],
    'Radioactivity': ['Becquerel', 'Curie'],
    'Luminous Flux': ['Lumens', 'Candela', 'Foot-lamberts'],
    'Acceleration': ['m/s²', 'ft/s²', 'G-force']
  };

  void _convert() {
    final input = double.tryParse(_controller.text) ?? 0;
    double convertedValue = 0;

    switch (_category) {
      case 'Energy':
        convertedValue = ConversionService.convertEnergy(input, _fromUnit, _toUnit);  
        break;
      case 'Power':
        convertedValue = ConversionService.convertPower(input, _fromUnit, _toUnit);  
        break;
      case 'Frequency':
        convertedValue = ConversionService.convertFrequency(input, _fromUnit, _toUnit);
        break;
      case 'Angle':
        convertedValue = ConversionService.convertAngle(input, _fromUnit, _toUnit);
        break;
      case 'Force':
        convertedValue = ConversionService.convertForce(input, _fromUnit, _toUnit);
        break;
      case 'Illuminance':
        convertedValue = ConversionService.convertIlluminance(input, _fromUnit, _toUnit);
        break;
      case 'Sound Level':
        convertedValue = ConversionService.convertSoundLevel(input, _fromUnit, _toUnit);
        break;
      case 'Torque':
        convertedValue = ConversionService.convertTorque(input, _fromUnit, _toUnit);
        break;
      case 'Luminance':
        convertedValue = ConversionService.convertLuminance(input, _fromUnit, _toUnit);
        break;
      case 'Density':
        convertedValue = ConversionService.convertDensity(input, _fromUnit, _toUnit);
        break;
      case 'Voltage':
        convertedValue = ConversionService.convertVoltage(input, _fromUnit, _toUnit);
        break;
      case 'Resistance':
        convertedValue = ConversionService.convertResistance(input, _fromUnit, _toUnit);
        break;
      case 'Capacitance':
        convertedValue = ConversionService.convertCapacitance(input, _fromUnit, _toUnit);
        break;
      case 'Inductance':
        convertedValue = ConversionService.convertInductance(input, _fromUnit, _toUnit);
        break;
      case 'Magnetic Flux':
        convertedValue = ConversionService.convertMagneticFlux(input, _fromUnit, _toUnit);
        break;
      case 'Magnetic Field Strength':
        convertedValue = ConversionService.convertMagneticFieldStrength(input, _fromUnit, _toUnit);
        break;
      case 'Radiation Dose':
        convertedValue = ConversionService.convertRadiationDose(input, _fromUnit, _toUnit);
        break;
      case 'Radioactivity':
        convertedValue = ConversionService.convertRadioactivity(input, _fromUnit, _toUnit);
        break;
      case 'Luminous Flux':
        convertedValue = ConversionService.convertLuminousFlux(input, _fromUnit, _toUnit);
        break;
      case 'Acceleration':
        convertedValue = ConversionService.convertAcceleration(input, _fromUnit, _toUnit);
        break;
      default:
        convertedValue = input;
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

