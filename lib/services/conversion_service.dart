class ConversionService {
  static double convertLength(double value, String from, String to) {
    const rates = {
      'Meters': 1.0,
      'Kilometers': 0.001,
      'Centimeters': 100.0,
      'Miles': 0.000621371,
      'Feet': 3.28084,
    };

    return value / rates[from]! * rates[to]!;
  }

  static double convertWeight(double value, String from, String to) {
    const rates = {
      'Kilograms': 1.0,
      'Grams': 1000.0,
      'Pounds': 2.20462,
      'Ounces': 35.274,
    };

    return value / rates[from]! * rates[to]!;
  }

  static double convertTemperature(double value, String from, String to) {
    if (from == to) return value;

    // Convert from source to Celsius first
    double celsius;
    switch (from) {
      case 'Fahrenheit':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'Kelvin':
        celsius = value - 273.15;
        break;
      default:
        celsius = value;
    }

    // Convert from Celsius to target
    switch (to) {
      case 'Fahrenheit':
        return celsius * 9 / 5 + 32;
      case 'Kelvin':
        return celsius + 273.15;
      default:
        return celsius;
    }
  }
}
