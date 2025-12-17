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
  bool _showResult = false;

  final Map<String, List<String>> unitCategories = {
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

  final Map<String, IconData> categoryIcons = {
    'Length': Icons.straighten_rounded,
    'Weight': Icons.scale_rounded,
    'Temperature': Icons.thermostat_rounded,
    'Area': Icons.crop_square_rounded,
    'Volume': Icons.water_drop_rounded,
    'Pressure': Icons.compress_rounded,
    'Time': Icons.schedule_rounded,
    'Speed': Icons.speed_rounded,
    'Fuel Consumption': Icons.local_gas_station_rounded,
    'Electrical Current': Icons.electric_bolt_rounded,
  };

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onInputChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_onInputChange);
    _controller.dispose();
    super.dispose();
  }

  void _onInputChange() {
    if (_controller.text.isEmpty) {
      if (_showResult) {
        setState(() {
          _showResult = false;
          _result = null;
        });
      }
    } else {
      _convert();
    }
  }

  void _convert() {
    final input = double.tryParse(_controller.text);
    if (input == null) return;

    final convertedValue = _performConversion(
      _category,
      input,
      _fromUnit,
      _toUnit,
    );

    setState(() {
      _result = convertedValue;
      _showResult = true;
    });
  }

  double _performConversion(
    String category,
    double input,
    String fromUnit,
    String toUnit,
  ) {
    switch (category) {
      case 'Length':
        return ConversionService.convertLength(input, fromUnit, toUnit);
      case 'Weight':
        return ConversionService.convertWeight(input, fromUnit, toUnit);
      case 'Temperature':
        return ConversionService.convertTemperature(input, fromUnit, toUnit);
      case 'Area':
        return ConversionService.convertArea(input, fromUnit, toUnit);
      case 'Volume':
        return ConversionService.convertVolume(input, fromUnit, toUnit);
      case 'Pressure':
        return ConversionService.convertPressure(input, fromUnit, toUnit);
      case 'Time':
        return ConversionService.convertTime(input, fromUnit, toUnit);
      case 'Speed':
        return ConversionService.convertSpeed(input, fromUnit, toUnit);
      case 'Fuel Consumption':
        return ConversionService.convertFuelConsumption(input, fromUnit, toUnit);
      case 'Electrical Current':
        return ConversionService.convertElectricalCurrent(input, fromUnit, toUnit);
      default:
        return 0;
    }
  }

  void _onCategoryChange(String newCategory) {
    setState(() {
      _category = newCategory;
      _fromUnit = unitCategories[newCategory]!.first;
      _toUnit = unitCategories[newCategory]!.last;
      _result = null;
      _showResult = false;
      _controller.clear();
    });
  }

  void _swapUnits() {
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      if (_controller.text.isNotEmpty) {
        _convert();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Modern header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        categoryIcons[_category],
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Unit Converter',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Main Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 12,
                  shadowColor: Colors.black38,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category selector
                        Text(
                          'Category',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: unitCategories.keys.length,
                            itemBuilder: (context, index) {
                              final category = unitCategories.keys.elementAt(index);
                              final isSelected = category == _category;
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: _buildCategoryCard(
                                  category,
                                  isSelected,
                                  colorScheme,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Input field
                        TextField(
                          controller: _controller,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Enter value',
                            hintText: 'e.g., 100',
                            filled: true,
                            fillColor: colorScheme.surfaceContainerHighest,
                            prefixIcon: Icon(
                              Icons.edit_rounded,
                              color: colorScheme.primary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: colorScheme.primary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // From Unit
                        _buildUnitSelector(
                          'From',
                          _fromUnit,
                          Icons.input_rounded,
                          (val) {
                            setState(() {
                              _fromUnit = val!;
                              if (_controller.text.isNotEmpty) _convert();
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Swap button
                        Center(
                          child: IconButton.filled(
                            onPressed: _swapUnits,
                            icon: const Icon(Icons.swap_vert_rounded),
                            tooltip: 'Swap units',
                            style: IconButton.styleFrom(
                              backgroundColor: colorScheme.secondaryContainer,
                              foregroundColor: colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // To Unit
                        _buildUnitSelector(
                          'To',
                          _toUnit,
                          Icons.output_rounded,
                          (val) {
                            setState(() {
                              _toUnit = val!;
                              if (_controller.text.isNotEmpty) _convert();
                            });
                          },
                        ),

                        // Result
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: _showResult
                              ? Column(
                                  children: [
                                    const SizedBox(height: 24),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            colorScheme.primaryContainer,
                                            colorScheme.secondaryContainer,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle_rounded,
                                                color: colorScheme.primary,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Result',
                                                style: theme.textTheme.titleSmall
                                                    ?.copyWith(
                                                  color: colorScheme.primary,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            _formatNumber(_result!),
                                            style: theme.textTheme.headlineMedium
                                                ?.copyWith(
                                              color: colorScheme.onPrimaryContainer,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            _toUnit,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                              color: colorScheme.onPrimaryContainer
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    String category,
    bool isSelected,
    ColorScheme colorScheme,
  ) {
    return GestureDetector(
      onTap: () => _onCategoryChange(category),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100,
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [colorScheme.primary, colorScheme.secondary],
                )
              : null,
          color: isSelected ? null : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              categoryIcons[category],
              color: isSelected ? Colors.white : colorScheme.onSurface,
              size: 32,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? Colors.white : colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitSelector(
    String label,
    String currentUnit,
    IconData icon,
    void Function(String?) onChanged,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentUnit,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: colorScheme.primary),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
              dropdownColor: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              items: unitCategories[_category]!.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  String _formatNumber(double value) {
    if (value.abs() >= 1e9) {
      return value.toStringAsExponential(4);
    } else if (value.abs() < 0.0001 && value != 0) {
      return value.toStringAsExponential(4);
    } else {
      return value
          .toStringAsFixed(value.truncateToDouble() == value ? 0 : 6)
          .replaceAll(RegExp(r'\.?0+$'), '');
    }
  }
}