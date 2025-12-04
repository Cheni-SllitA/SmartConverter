import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static const String _baseUrl = 'https://api.exchangerate-api.com/v4/latest';

  /// Fetches conversion rate between two currencies.
  static Future<double?> getExchangeRate(String from, String to) async {
    try {
      final url = Uri.parse('$_baseUrl/$from'); // e.g., https://api.exchangerate-api.com/v4/latest/USD
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final rates = data['rates'] as Map<String, dynamic>;
        return (rates[to] as num?)?.toDouble();
      } else {
        throw Exception('Failed to load exchange rate: ${response.statusCode}');
      }
    } catch (e) {
      throw('Error fetching exchange rate: $e');

    }
  }

  /// Fetches all available currency codes.
  static Future<List<String>> getAvailableCurrencies() async {
    try {
      final url = Uri.parse('$_baseUrl/USD'); // base with default USD
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final rates = data['rates'] as Map<String, dynamic>;
        return rates.keys.toList();
      } else {
        throw Exception('Failed to load currency list: ${response.statusCode}');
      }
    } catch (e) {
      throw('Error fetching currency list: $e');
    }
  }
}
