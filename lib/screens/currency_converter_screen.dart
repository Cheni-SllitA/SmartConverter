import 'package:flutter/material.dart';
import '../services/currency_service.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'LKR';
  double? _result;
  double? _exchangeRate;
  bool _isLoading = false;
  bool _showResult = false;
  String? _errorMessage;
  List<String> _currencies = ['USD', 'LKR', 'EUR', 'GBP', 'INR'];
  DateTime? _lastUpdateTime;

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
    _controller.addListener(_onInputChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_onInputChange);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadCurrencies() async {
    try {
      final list = await CurrencyService.getAvailableCurrencies();
      if (mounted) {
        setState(() {
          _currencies = list;
        });
      }
    } catch (e) {
      debugPrint('Failed to load currency list: $e');
    }
  }

  void _onInputChange() {
    if (_controller.text.isEmpty) {
      if (_showResult) {
        setState(() {
          _showResult = false;
          _result = null;
        });
      }
    } else if (_exchangeRate != null) {
      // Use cached rate for instant calculation
      final input = double.tryParse(_controller.text);
      if (input != null) {
        setState(() {
          _result = input * _exchangeRate!;
          _showResult = true;
        });
      }
    }
  }

  Future<void> _convert() async {
    FocusScope.of(context).unfocus();
    
    final input = double.tryParse(_controller.text);
    if (input == null || input <= 0) {
      setState(() {
        _errorMessage = 'Please enter a valid amount';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final rate =
          await CurrencyService.getExchangeRate(_fromCurrency, _toCurrency);
      
      if (rate != null && mounted) {
        setState(() {
          _exchangeRate = rate;
          _result = input * rate;
          _showResult = true;
          _lastUpdateTime = DateTime.now();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch conversion rate';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Network error. Please try again.';
          _isLoading = false;
        });
      }
    }
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      
      // Recalculate with swapped currencies
      if (_exchangeRate != null && _result != null) {
        _exchangeRate = 1 / _exchangeRate!;
        final input = double.tryParse(_controller.text);
        if (input != null) {
          _result = input * _exchangeRate!;
        }
      }
    });
  }

  String _getRelativeTime() {
    if (_lastUpdateTime == null) return '';
    final diff = DateTime.now().difference(_lastUpdateTime!);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
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
                      child: const Icon(
                        Icons.currency_exchange_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Currency Converter',
                      style: TextStyle(
                        fontSize: 27,
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
                        // Amount input
                        Text(
                          'Amount',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _controller,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: '0.00',
                            filled: true,
                            fillColor: colorScheme.surfaceContainerHighest,
                            prefixIcon: Icon(
                              Icons.attach_money_rounded,
                              color: colorScheme.primary,
                              size: 28,
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
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 20,
                            ),
                          ),
                        ),
                        
                        // Error message
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 16,
                                  color: colorScheme.error,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _errorMessage!,
                                  style: TextStyle(
                                    color: colorScheme.error,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        const SizedBox(height: 24),

                        // From Currency
                        _buildCurrencySelector(
                          'From',
                          _fromCurrency,
                          Icons.wallet_rounded,
                          (val) {
                            setState(() {
                              _fromCurrency = val!;
                              _exchangeRate = null; // Reset cached rate
                            });
                          },
                        ),
                        
                        const SizedBox(height: 16),

                        // Swap button
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: _swapCurrencies,
                              icon: const Icon(Icons.swap_vert_rounded),
                              tooltip: 'Swap currencies',
                              color: colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 16),

                        // To Currency
                        _buildCurrencySelector(
                          'To',
                          _toCurrency,
                          Icons.account_balance_wallet_rounded,
                          (val) {
                            setState(() {
                              _toCurrency = val!;
                              _exchangeRate = null; // Reset cached rate
                            });
                          },
                        ),
                        
                        const SizedBox(height: 24),

                        // Convert button
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: colorScheme.primary,
                            ),
                            onPressed: _isLoading ? null : _convert,
                            icon: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.sync_rounded),
                            label: Text(
                              _isLoading ? 'Converting...' : 'Get Latest Rate',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        // Result with exchange rate info
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: _showResult && _result != null
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
                                            colorScheme.tertiaryContainer,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: colorScheme.primary
                                              .withOpacity(0.2),
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.trending_up_rounded,
                                                    color: colorScheme.primary,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'Converted Amount',
                                                    style: theme
                                                        .textTheme.titleSmall
                                                        ?.copyWith(
                                                      color: colorScheme.primary,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (_lastUpdateTime != null)
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: colorScheme.surface
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    _getRelativeTime(),
                                                    style: theme
                                                        .textTheme.labelSmall
                                                        ?.copyWith(
                                                      color: colorScheme
                                                          .onSurface
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _toCurrency,
                                                      style: theme.textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                        color: colorScheme
                                                            .onPrimaryContainer
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        _formatCurrency(_result!),
                                                        style: theme.textTheme
                                                            .headlineLarge
                                                            ?.copyWith(
                                                          color: colorScheme
                                                              .onPrimaryContainer,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (_exchangeRate != null) ...[
                                            const SizedBox(height: 16),
                                            Divider(
                                              color: colorScheme.onPrimaryContainer
                                                  .withOpacity(0.2),
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.info_outline_rounded,
                                                  size: 16,
                                                  color: colorScheme
                                                      .onPrimaryContainer
                                                      .withOpacity(0.6),
                                                ),
                                                const SizedBox(width: 8),
                                                Flexible(
                                                  child: Text(
                                                    '1 $_fromCurrency = ${_exchangeRate!.toStringAsFixed(4)} $_toCurrency',
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color: colorScheme
                                                          .onPrimaryContainer
                                                          .withOpacity(0.7),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
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

  Widget _buildCurrencySelector(
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
          items: _currencies
              .map((c) => DropdownMenuItem(
                    value: c,
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              c.substring(0, 1),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          c,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  String _formatCurrency(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)}K';
    }
    return value.toStringAsFixed(2);
  }
}