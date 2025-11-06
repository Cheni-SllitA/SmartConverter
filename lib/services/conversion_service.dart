class ConversionService {

  //length conversion
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

  //temperature conversion
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

//Area conversion function
static double convertArea(double value, String from, String to) {
  const rates = {
    'Square Meters': 1.0,
    'Square Kilometers': 1e6,
    'Square Feet': 0.092903,
    'Square Inches': 0.00064516,
    'Acres': 4046.86,
    'Square Miles': 2.59e6,
    'Hectares': 10000.0,
  };

  return value * (rates[from]! / rates[to]!);
}

//volume conversion function
static double convertVolume(double value, String from, String to) {
  const rates = {
    'Liters': 1.0,
    'Milliliters': 0.001,
    'Cubic Meters': 1000.0,
    'Cubic Feet': 28.3168,
    'Gallons': 3.78541,
    'Quarts': 0.946353,
    'Pints': 0.473176,
  };

  return value * (rates[from]! / rates[to]!);
}

//Pressure conversion function
static double convertPressure(double value, String from, String to) {
  const rates = {
    'Pascals': 1.0,
    'Bar': 100000.0,
    'PSI': 6894.76,
    'Atmospheres': 101325.0,
    'Torr': 133.322,
    'mmHg': 133.322,
  };

  return value * (rates[from]! / rates[to]!);
}

//Time conversion function
static double convertTime(double value, String from, String to) {
  const rates = {
    'Seconds': 1.0,
    'Minutes': 60.0,
    'Hours': 3600.0,
    'Days': 86400.0,
    'Weeks': 604800.0,
    'Months': 2.628e6, // approx 30.44 days
    'Years': 3.154e7,  // approx 365.25 days
  };

  return value * (rates[from]! / rates[to]!);
}

//speed conversion function
static double convertSpeed(double value, String from, String to) {
  const rates = {
    'Meters/Second': 1.0,
    'Kilometers/Hour': 0.277778,
    'Miles/Hour': 0.44704,
    'Knots': 0.514444,
    'Feet/Second': 0.3048,
    'Mach': 340.29, // at sea level
  };

  return value * (rates[from]! / rates[to]!);
}

//fuel consumption function
static double convertFuelConsumption(double value, String from, String to) {
  double litersPer100km;

  // Convert input to Liters/100km
  switch (from) {
    case 'Liters/100km':
      litersPer100km = value;
      break;
    case 'Miles/Gallon (US)':
      litersPer100km = 235.215 / value;
      break;
    case 'Miles/Gallon (UK)':
      litersPer100km = 282.481 / value;
      break;
    case 'Kilometers/Liter':
      litersPer100km = 100 / value;
      break;
    default:
      return double.nan;
  }

  // Convert Liters/100km to target
  switch (to) {
    case 'Liters/100km':
      return litersPer100km;
    case 'Miles/Gallon (US)':
      return 235.215 / litersPer100km;
    case 'Miles/Gallon (UK)':
      return 282.481 / litersPer100km;
    case 'Kilometers/Liter':
      return 100 / litersPer100km;
    default:
      return double.nan;
  }
}

//electrical current convert function
static double convertElectricalCurrent(double value, String from, String to) {
  const rates = {
    'Amperes': 1.0,
    'Milliamperes': 0.001,
    'Microamperes': 0.000001,
    'Kiloamperes': 1000.0,
  };

  return value * (rates[from]! / rates[to]!);
}



  //____________________________________________________________________________________________________________________________
  //computer science conversions
  //____________________________________________________________________________________________________________________________
  // Data Storage Conversion
  static double convertDataStorage(double value, String from, String to) {
    const rates = {
      'Bits': 1,
      'Bytes': 8,
      'Kilobytes': 8 * 1024,
      'Megabytes': 8 * 1024 * 1024,
      'Gigabytes': 8 * 1024 * 1024 * 1024,
      'Terabytes': 8 * 1024 * 1024 * 1024 * 1024,
      'Petabytes': 8 * 1024 * 1024 * 1024 * 1024 * 1024,
    };

    // Convert to bits first, then to target
    return value * rates[from]! / rates[to]!;
  }

  // Network Speed Conversion
  static double convertNetworkSpeed(double value, String from, String to) {
    const rates = {
      'Bits per Second (bps)': 1.0,
      'Kilobits per Second (Kbps)': 1e3,
      'Megabits per Second (Mbps)': 1e6,
      'Gigabits per Second (Gbps)': 1e9,
      'Terabits per Second (Tbps)': 1e12,
      'Bytes per Second (Bps)': 8.0,
      'Megabytes per Second (MBps)': 8.0 * 1e6,
    };

    // Convert to bits per second, then to target
    return value * rates[from]! / rates[to]!;
  }

  // ✅ Number System Conversion (integer base conversions)
  // Inside ConversionService
  static String convertNumberSystem(String input, String from, String to) {
    // Define base values for each system
    final baseMap = {
      'Binary': 2,
      'Octal': 8,
      'Decimal': 10,
      'Hexadecimal': 16,
      'Duodecimal': 12,
      'Base-32': 32,
      'Base-64': 64,
    };

    // Helper function to decode a string in any base to integer
    int decode(String value, int base) {
      const digits =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
      int result = 0;
      for (int i = 0; i < value.length; i++) {
        int digit = digits.indexOf(value[i].toUpperCase());
        if (digit < 0 || digit >= base) {
          throw FormatException(
            'Invalid character for base-$base: ${value[i]}',
          );
        }
        result = result * base + digit;
      }
      return result;
    }

    // Helper function to encode integer into a string in any base
    String encode(int value, int base) {
      const digits =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
      if (value == 0) return '0';
      String result = '';
      while (value > 0) {
        result = digits[value % base] + result;
        value ~/= base;
      }
      return result;
    }

    // Handle invalid bases
    if (!baseMap.containsKey(from) || !baseMap.containsKey(to)) {
      throw ArgumentError('Unsupported number system: $from or $to');
    }

    // Convert input → decimal → target base
    int fromBase = baseMap[from]!;
    int toBase = baseMap[to]!;

    int decimalValue = decode(input, fromBase);
    String converted = encode(decimalValue, toBase);

    return converted;
  }

  // Helper method to convert decimal to any base (up to 64)
  static String _toBase(int number, int base) {
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
    if (number == 0) return '0';
    String result = '';
    int n = number;
    while (n > 0) {
      result = chars[n % base] + result;
      n ~/= base;
    }
    return result;
  }


//_________________________________________________________________________________________________________________________
//Scientific based conversions
//__________________________________________________________________________________________________________________________
  static double convertEnergy(double value, String from, String to) {
    const rates = {
      'Joules': 1.0,
      'Calories': 4.184,
      'Kilocalories': 4184.0,
      'Kilowatt-hours': 3.6e6,
      'BTU': 1055.06,
      'Electronvolts': 1.60218e-19,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertPower(double value, String from, String to) {
    const rates = {
      'Watts': 1.0,
      'Kilowatts': 1000.0,
      'Megawatts': 1e6,
      'Horsepower': 745.7,
      'BTU/Hour': 0.293071,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertFrequency(double value, String from, String to) {
    const rates = {
      'Hertz': 1.0,
      'Kilohertz': 1e3,
      'Megahertz': 1e6,
      'Gigahertz': 1e9,
      'Terahertz': 1e12,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertAngle(double value, String from, String to) {
    const rates = {
      'Degrees': 1.0,
      'Radians': 57.2958,
      'Gradians': 0.9,
      'Turns': 360.0,
      'Arcminutes': 1 / 60.0,
      'Arcseconds': 1 / 3600.0,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertForce(double value, String from, String to) {
    const rates = {
      'Newtons': 1.0,
      'Pounds-force': 4.44822,
      'Kilograms-force': 9.80665,
      'Dynes': 1e-5,
      'Kilonewtons': 1000.0,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertIlluminance(double value, String from, String to) {
    const rates = {
      'Lux': 1.0,
      'Foot-candles': 10.7639,
      'Phot': 10000.0,
      'Nits': 3.1831,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertSoundLevel(double value, String from, String to) {
    // Direct linear conversion doesn't apply perfectly to dB/Phon/Sone/Nepers,
    // but for simplicity, we assume approximate proportional conversions.
    const rates = {
      'Decibels': 1.0,
      'Phons': 1.0,
      'Sones': 0.301,
      'Nepers': 8.686,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertTorque(double value, String from, String to) {
    const rates = {
      'Newton-meters': 1.0,
      'Pound-feet': 1.35582,
      'Kilogram-meters': 9.80665,
      'Dyne-centimeters': 1e-7,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertLuminance(double value, String from, String to) {
    const rates = {
      'Candela/Square Meter': 1.0,
      'Foot-lamberts': 3.426,
      'Nits': 1.0,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertDensity(double value, String from, String to) {
    const rates = {
      'Kilograms/Cubic Meter': 1.0,
      'Grams/Cubic Centimeter': 1000.0,
      'Pounds/Cubic Foot': 16.0185,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertVoltage(double value, String from, String to) {
    const rates = {'Volts': 1.0, 'Millivolts': 0.001, 'Kilovolts': 1000.0};
    return value * (rates[to]! / rates[from]!);
  }

  static double convertResistance(double value, String from, String to) {
    const rates = {'Ohms': 1.0, 'Kiloohms': 1000.0, 'Megaohms': 1e6};
    return value * (rates[to]! / rates[from]!);
  }

  static double convertCapacitance(double value, String from, String to) {
    const rates = {
      'Farads': 1.0,
      'Microfarads': 1e-6,
      'Nanofarads': 1e-9,
      'Picofarads': 1e-12,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertInductance(double value, String from, String to) {
    const rates = {'Henrys': 1.0, 'Millihenrys': 1e-3, 'Microhenrys': 1e-6};
    return value * (rates[to]! / rates[from]!);
  }

  static double convertMagneticFlux(double value, String from, String to) {
    const rates = {'Weber': 1.0, 'Maxwell': 1e-8};
    return value * (rates[to]! / rates[from]!);
  }

  static double convertMagneticFieldStrength(
    double value,
    String from,
    String to,
  ) {
    const rates = {'Tesla': 1.0, 'Gauss': 1e-4};
    return value * (rates[to]! / rates[from]!);
  }

  static double convertRadiationDose(double value, String from, String to) {
    const rates = {'Gray': 1.0, 'Sievert': 1.0, 'Rad': 0.01, 'Rem': 0.01};
    return value * (rates[to]! / rates[from]!);
  }

  static double convertRadioactivity(double value, String from, String to) {
    const rates = {'Becquerel': 1.0, 'Curie': 3.7e10};
    return value * (rates[to]! / rates[from]!);
  }

  static double convertLuminousFlux(double value, String from, String to) {
    const rates = {
      'Lumens': 1.0,
      'Candela': 1.0 / (4 * 3.1416), // 1 lumen = 1 candela·steradian (approx.)
      'Foot-lamberts': 3.426,
    };
    return value * (rates[to]! / rates[from]!);
  }

  static double convertAcceleration(double value, String from, String to) {
    const rates = {
      'Meters/Second²': 1.0,
      'Feet/Second²': 0.3048,
      'G-force': 9.80665,
    };
    return value * (rates[to]! / rates[from]!);
  }
}
