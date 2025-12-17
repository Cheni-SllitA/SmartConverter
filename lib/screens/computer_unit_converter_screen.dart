import 'package:flutter/material.dart';
import '../services/conversion_service.dart';

class ComputerUnitConverterScreen extends StatefulWidget {
  const ComputerUnitConverterScreen({super.key});

  @override
  State<ComputerUnitConverterScreen> createState() =>
      _ComputerUnitConverterScreenState();
}

class _ComputerUnitConverterScreenState
    extends State<ComputerUnitConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _category = 'Data Storage';
  String _fromUnit = 'Bits';
  String _toUnit = 'Bytes';
  double? _result;
  String? _stringResult;
  bool _showResult = false;

  final Map<String, List<String>> unitCategories = {
    'Data Storage': [
      'Bits',
      'Bytes',
      'Kilobytes',
      'Megabytes',
      'Gigabytes',
      'Terabytes',
      'Petabytes',
    ],
    'Network Speed': [
      'Bits per Second (bps)',
      'Kilobits per Second (Kbps)',
      'Megabits per Second (Mbps)',
      'Gigabits per Second (Gbps)',
      'Terabits per Second (Tbps)',
      'Bytes per Second (Bps)',
      'Megabytes per Second (MBps)',
    ],
    'Number System': [
      'Binary',
      'Octal',
      'Decimal',
      'Hexadecimal',
      'Duodecimal',
      'Base-32',
      'Base-64',
    ],
  };

  // Category icons for better visual identification
  final Map<String, IconData> categoryIcons = {
    'Data Storage': Icons.storage_rounded,
    'Network Speed': Icons.network_check_rounded,
    'Number System': Icons.tag_rounded,
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
          _stringResult = null;
        });
      }
    } else {
      _convert();
    }
  }

  void _convert() {
    final inputText = _controller.text.trim();
    if (inputText.isEmpty) return;

    if (_category == 'Number System') {
      final converted =
          ConversionService.convertNumberSystem(inputText, _fromUnit, _toUnit);
      setState(() {
        _stringResult = converted;
        _result = null;
        _showResult = true;
      });
    } else {
      final input = double.tryParse(inputText);
      if (input == null) return;

      final convertedValue = _category == 'Data Storage'
          ? ConversionService.convertDataStorage(input, _fromUnit, _toUnit)
          : ConversionService.convertNetworkSpeed(input, _fromUnit, _toUnit);

      setState(() {
        _result = convertedValue;
        _stringResult = null;
        _showResult = true;
      });
    }
  }

  void _onCategoryChange(String newCategory) {
    setState(() {
      _category = newCategory;
      _fromUnit = unitCategories[newCategory]!.first;
      _toUnit = unitCategories[newCategory]!.last;
      _result = null;
      _stringResult = null;
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
                      'Computer Converter',
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
                              final category =
                                  unitCategories.keys.elementAt(index);
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
                          keyboardType: _category == 'Number System'
                              ? TextInputType.text
                              : const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Enter value',
                            hintText: _category == 'Number System'
                                ? 'e.g., 1010'
                                : 'e.g., 100',
                            filled: true,
                            fillColor: colorScheme.surfaceContainerHighest,
                            prefixIcon: Icon(
                              _category == 'Number System'
                                  ? Icons.tag
                                  : Icons.edit_rounded,
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
                                                    .textTheme.titleSmall
                                                    ?.copyWith(
                                                  color: colorScheme.primary,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            _stringResult ??
                                                _formatNumber(_result!),
                                            style: theme
                                                .textTheme.headlineMedium
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
        width: 140,
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.secondary,
                  ],
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: unitCategories[_category]!
              .map((u) => DropdownMenuItem(
                    value: u,
                    child: Text(
                      u,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ))
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