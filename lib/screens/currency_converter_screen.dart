import 'package:flutter/material.dart';
import '../services/currency_service.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'LKR';
  double? _result;
  bool _isLoading = false;
  List<String> _currencies = ['USD', 'LKR', 'EUR', 'GBP', 'INR'];

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
  }

  Future<void> _loadCurrencies() async {
    try {
      final list = await CurrencyService.getAvailableCurrencies();
      setState(() {
        _currencies = list;
      });
    } catch (e) {
      // fallback to default list if API fails
      debugPrint('Failed to load currency list: $e');
    }
  }

  Future<void> _convert() async {
    setState(() => _isLoading = true);
    final input = double.tryParse(_controller.text) ?? 0;

    try {
      final rate = await CurrencyService.getExchangeRate(_fromCurrency, _toCurrency);
      if (rate != null) {
        setState(() => _result = input * rate);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch conversion rate')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Enter amount'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: _fromCurrency,
                items: _currencies
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _fromCurrency = val!),
              ),
              const Icon(Icons.arrow_forward),
              DropdownButton<String>(
                value: _toCurrency,
                items: _currencies
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _toCurrency = val!),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _convert,
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Convert'),
          ),
          const SizedBox(height: 20),
          if (_result != null)
            Text(
              '$_fromCurrency ${_controller.text} = ${_result!.toStringAsFixed(2)} $_toCurrency',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
