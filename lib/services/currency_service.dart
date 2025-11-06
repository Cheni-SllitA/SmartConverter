import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static const String _baseUrl = 'https://api.exchangerate.host';

  /// Fetches conversion rate between two currencies.
  static Future<double?> getExchangeRate(String from, String to) async {
    final url = Uri.parse('$_baseUrl/convert?from=$from&to=$to');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['result'] as num?)?.toDouble();
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }

  /// Optional: Get all available currency symbols.
  static Future<List<String>> getAvailableCurrencies() async {
    final url = Uri.parse('$_baseUrl/symbols');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final symbols = data['symbols'] as Map<String, dynamic>;
      return symbols.keys.toList();
    } else {
      throw Exception('Failed to load currency list');
    }
  }
}
