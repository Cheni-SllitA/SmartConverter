import 'package:flutter/material.dart';
import '../services/conversion_service.dart';

class ScientificUnitConverterScreen extends StatefulWidget {
  const ScientificUnitConverterScreen({super.key});

  @override
  State<ScientificUnitConverterScreen> createState() =>
      _ScientificUnitConverterScreenState();
}

class _ScientificUnitConverterScreenState
    extends State<ScientificUnitConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _category = 'Energy';
  String _fromUnit = 'Joules';
  String _toUnit = 'Calories';
  double? _result;
  bool _showResult = false;

  final Map<String, List<String>> unitCategories = {
    'Energy': [
      'Joules',
      'Calories',
      'Kilocalories',
      'Kilowatt-hours',
      'BTU',
      'Electronvolts',
    ],
    'Power': ['Watts', 'Kilowatts', 'Megawatts', 'Horsepower', 'BTU/Hour'],
    'Frequency': ['Hertz', 'Kilohertz', 'Megahertz', 'Gigahertz', 'Terahertz'],
    'Angle': [
      'Degrees',
      'Radians',
      'Gradians',
      'Turns',
      'Arcminutes',
      'Arcseconds',
    ],
    'Force': [
      'Newtons',
      'Pounds-force',
      'Kilograms-force',
      'Dynes',
      'Kilonewtons',
    ],
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
    'Acceleration': ['m/s²', 'ft/s²', 'G-force'],
  };

  // Category icons for better visual identification
  final Map<String, IconData> categoryIcons = {
    'Energy': Icons.bolt_rounded,
    'Power': Icons.power_rounded,
    'Frequency': Icons.waves_rounded,
    'Angle': Icons.rotate_right_rounded,
    'Force': Icons.fitness_center_rounded,
    'Illuminance': Icons.lightbulb_rounded,
    'Sound Level': Icons.volume_up_rounded,
    'Torque': Icons.settings_rounded,
    'Luminance': Icons.brightness_7_rounded,
    'Density': Icons.compress_rounded,
    'Voltage': Icons.flash_on_rounded,
    'Resistance': Icons.electrical_services_rounded,
    'Capacitance': Icons.battery_charging_full_rounded,
    'Inductance': Icons.looks_rounded,
    'Magnetic Flux': Icons.wb_sunny_rounded,
    'Magnetic Field Strength': Icons.explore_rounded,
    'Radiation Dose': Icons.radio_button_checked_rounded,
    'Radioactivity': Icons.science_rounded,
    'Luminous Flux': Icons.wb_incandescent_rounded,
    'Acceleration': Icons.speed_rounded,
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

    // Direct conversion (no isolate needed for simple math)
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
    String from,
    String to,
  ) {
    switch (category) {
      case 'Energy':
        return ConversionService.convertEnergy(input, from, to);
      case 'Power':
        return ConversionService.convertPower(input, from, to);
      case 'Frequency':
        return ConversionService.convertFrequency(input, from, to);
      case 'Angle':
        return ConversionService.convertAngle(input, from, to);
      case 'Force':
        return ConversionService.convertForce(input, from, to);
      case 'Illuminance':
        return ConversionService.convertIlluminance(input, from, to);
      case 'Sound Level':
        return ConversionService.convertSoundLevel(input, from, to);
      case 'Torque':
        return ConversionService.convertTorque(input, from, to);
      case 'Luminance':
        return ConversionService.convertLuminance(input, from, to);
      case 'Density':
        return ConversionService.convertDensity(input, from, to);
      case 'Voltage':
        return ConversionService.convertVoltage(input, from, to);
      case 'Resistance':
        return ConversionService.convertResistance(input, from, to);
      case 'Capacitance':
        return ConversionService.convertCapacitance(input, from, to);
      case 'Inductance':
        return ConversionService.convertInductance(input, from, to);
      case 'Magnetic Flux':
        return ConversionService.convertMagneticFlux(input, from, to);
      case 'Magnetic Field Strength':
        return ConversionService.convertMagneticFieldStrength(input, from, to);
      case 'Radiation Dose':
        return ConversionService.convertRadiationDose(input, from, to);
      case 'Radioactivity':
        return ConversionService.convertRadioactivity(input, from, to);
      case 'Luminous Flux':
        return ConversionService.convertLuminousFlux(input, from, to);
      case 'Acceleration':
        return ConversionService.convertAcceleration(input, from, to);
      default:
        return input;
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
          colors: [colorScheme.primary, colorScheme.secondary],
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
                      'Scientific Converter',
                      style: TextStyle(
                        fontSize: 26.5,
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
                        // Category selector with visual grid
                        Text(
                          'Category',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Category grid for better UX
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: unitCategories.keys.length,
                            itemBuilder: (context, index) {
                              final category = unitCategories.keys.elementAt(
                                index,
                              );
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

                        // Result with smooth animation
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
                                                style: theme
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                      color:
                                                          colorScheme.primary,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            _formatNumber(_result!),
                                            style: theme
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                  color: colorScheme
                                                      .onPrimaryContainer,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            _toUnit,
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                  color: colorScheme
                                                      .onPrimaryContainer
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
    String value,
    IconData icon,
    Function(String?) onChanged,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Row(
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
        ),
        DropdownButtonFormField<String>(
          initialValue: value,
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: unitCategories[_category]!
              .map(
                (u) => DropdownMenuItem(
                  value: u,
                  child: Text(
                    u,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
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
