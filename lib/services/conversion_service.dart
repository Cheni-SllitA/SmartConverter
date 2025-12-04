class ConversionService {
  // Length conversion - ALL RATES IN METERS
  static double convertLength(double value, String from, String to) {
    const rates = {
      'Meters': 1.0,
      'Kilometers': 1000.0,
      'Centimeters': 0.01,
      'Millimeters': 0.001,
      'Miles': 1609.34,
      'Feet': 0.3048,
      'Inches': 0.0254,
      'Yards': 0.9144,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Weight conversion - ALL RATES IN KILOGRAMS
  static double convertWeight(double value, String from, String to) {
    const rates = {
      'Kilograms': 1.0,
      'Grams': 0.001,
      'Milligrams': 0.000001,
      'Pounds': 0.453592,
      'Ounces': 0.0283495,
      'Stones': 6.35029,
      'Tons': 1000.0,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Temperature conversion - CORRECT (non-linear)
  static double convertTemperature(double value, String from, String to) {
    if (from == to) return value;

    // Convert to Celsius first
    double celsius;
    switch (from) {
      case 'Celsius':
        celsius = value;
        break;
      case 'Fahrenheit':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'Kelvin':
        celsius = value - 273.15;
        break;
      case 'Rankine':
        celsius = (value - 491.67) * 5 / 9;
        break;
      default:
        celsius = value;
    }

    // Convert from Celsius to target
    switch (to) {
      case 'Celsius':
        return celsius;
      case 'Fahrenheit':
        return celsius * 9 / 5 + 32;
      case 'Kelvin':
        return celsius + 273.15;
      case 'Rankine':
        return (celsius + 273.15) * 9 / 5;
      default:
        return celsius;
    }
  }

  // Area conversion - ALL RATES IN SQUARE METERS
  static double convertArea(double value, String from, String to) {
    const rates = {
      'Square Meters': 1.0,
      'Square Kilometers': 1000000.0,
      'Square Centimeters': 0.0001,
      'Square Feet': 0.092903,
      'Square Inches': 0.00064516,
      'Square Miles': 2589988.11,
      'Acres': 4046.86,
      'Hectares': 10000.0,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Volume conversion - ALL RATES IN LITERS
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
    return value * rates[from]! / rates[to]!;
  }

  // Pressure conversion - ALL RATES IN PASCALS
  static double convertPressure(double value, String from, String to) {
    const rates = {
      'Pascals': 1.0,
      'Bar': 100000.0,
      'PSI': 6894.76,
      'Atmospheres': 101325.0,
      'Torr': 133.322,
      'mmHg': 133.322,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Time conversion - ALL RATES IN SECONDS
  static double convertTime(double value, String from, String to) {
    const rates = {
      'Seconds': 1.0,
      'Minutes': 60.0,
      'Hours': 3600.0,
      'Days': 86400.0,
      'Weeks': 604800.0,
      'Months': 2628000.0, // 30.44 days average
      'Years': 31536000.0, // 365 days
    };
    return value * rates[from]! / rates[to]!;
  }

  // Speed conversion - ALL RATES IN METERS/SECOND
  static double convertSpeed(double value, String from, String to) {
    const rates = {
      'Meters/Second': 1.0,
      'Kilometers/Hour': 0.277778,
      'Miles/Hour': 0.44704,
      'Knots': 0.514444,
      'Feet/Second': 0.3048,
      'Mach': 343.0, // at sea level, 20°C
    };
    return value * rates[from]! / rates[to]!;
  }

  // Fuel Consumption - CORRECT (non-linear)
  static double convertFuelConsumption(double value, String from, String to) {
    if (value == 0) return 0;

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

  // Electrical Current - ALL RATES IN AMPERES
  static double convertElectricalCurrent(double value, String from, String to) {
    const rates = {
      'Amperes': 1.0,
      'Milliamperes': 0.001,
      'Microamperes': 0.000001,
      'Kiloamperes': 1000.0,
    };
    return value * rates[from]! / rates[to]!;
  }

  // ═══════════════════════════════════════════════════════════════
  // COMPUTER SCIENCE CONVERSIONS
  // ═══════════════════════════════════════════════════════════════

  // Data Storage - ALL RATES IN BITS
  static double convertDataStorage(double value, String from, String to) {
    const rates = {
      'Bits': 1.0,
      'Bytes': 8.0,
      'Kilobytes': 8192.0, // 8 * 1024
      'Megabytes': 8388608.0, // 8 * 1024^2
      'Gigabytes': 8589934592.0, // 8 * 1024^3
      'Terabytes': 8796093022208.0, // 8 * 1024^4
      'Petabytes': 9007199254740992.0, // 8 * 1024^5
    };
    return value * rates[from]! / rates[to]!;
  }

  // Network Speed - ALL RATES IN BITS PER SECOND
  static double convertNetworkSpeed(double value, String from, String to) {
    const rates = {
      'Bits per Second (bps)': 1.0,
      'Kilobits per Second (Kbps)': 1000.0,
      'Megabits per Second (Mbps)': 1000000.0,
      'Gigabits per Second (Gbps)': 1000000000.0,
      'Terabits per Second (Tbps)': 1000000000000.0,
      'Bytes per Second (Bps)': 8.0,
      'Megabytes per Second (MBps)': 8000000.0,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Number System Conversion - CORRECT
  static String convertNumberSystem(String input, String from, String to) {
    final baseMap = {
      'Binary': 2,
      'Octal': 8,
      'Decimal': 10,
      'Hexadecimal': 16,
      'Duodecimal': 12,
      'Base-32': 32,
      'Base-64': 64,
    };

    int decode(String value, int base) {
      const digits =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
      int result = 0;
      for (int i = 0; i < value.length; i++) {
        int digit = digits.indexOf(value[i].toUpperCase());
        if (digit < 0 || digit >= base) {
          throw FormatException('Invalid character for base-$base: ${value[i]}');
        }
        result = result * base + digit;
      }
      return result;
    }

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

    if (!baseMap.containsKey(from) || !baseMap.containsKey(to)) {
      throw ArgumentError('Unsupported number system: $from or $to');
    }

    int fromBase = baseMap[from]!;
    int toBase = baseMap[to]!;

    int decimalValue = decode(input, fromBase);
    String converted = encode(decimalValue, toBase);

    return converted;
  }

  // ═══════════════════════════════════════════════════════════════
  // SCIENTIFIC CONVERSIONS
  // ═══════════════════════════════════════════════════════════════

  // Energy - ALL RATES IN JOULES
  static double convertEnergy(double value, String from, String to) {
    const rates = {
      'Joules': 1.0,
      'Calories': 4.184,
      'Kilocalories': 4184.0,
      'Kilowatt-hours': 3600000.0,
      'BTU': 1055.06,
      'Electronvolts': 1.60218e-19,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Power - ALL RATES IN WATTS
  static double convertPower(double value, String from, String to) {
    const rates = {
      'Watts': 1.0,
      'Kilowatts': 1000.0,
      'Megawatts': 1000000.0,
      'Horsepower': 745.7,
      'BTU/Hour': 0.293071,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Frequency - ALL RATES IN HERTZ
  static double convertFrequency(double value, String from, String to) {
    const rates = {
      'Hertz': 1.0,
      'Kilohertz': 1000.0,
      'Megahertz': 1000000.0,
      'Gigahertz': 1000000000.0,
      'Terahertz': 1000000000000.0,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Angle - ALL RATES IN DEGREES
  static double convertAngle(double value, String from, String to) {
    const rates = {
      'Degrees': 1.0,
      'Radians': 57.2958,
      'Gradians': 0.9,
      'Turns': 360.0,
      'Arcminutes': 1 / 60.0,
      'Arcseconds': 1 / 3600.0,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Force - ALL RATES IN NEWTONS
  static double convertForce(double value, String from, String to) {
    const rates = {
      'Newtons': 1.0,
      'Pounds-force': 4.44822,
      'Kilograms-force': 9.80665,
      'Dynes': 0.00001,
      'Kilonewtons': 1000.0,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Illuminance - ALL RATES IN LUX
  static double convertIlluminance(double value, String from, String to) {
    const rates = {
      'Lux': 1.0,
      'Foot-candles': 10.7639,
      'Phot': 10000.0,
      'Nits': 3.1831,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Sound Level - Approximate conversion
  static double convertSoundLevel(double value, String from, String to) {
    const rates = {
      'Decibels': 1.0,
      'Phons': 1.0,
      'Sones': 33.22, // Approximate: 1 sone ≈ 40 dB
      'Nepers': 8.686,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Torque - ALL RATES IN NEWTON-METERS
  static double convertTorque(double value, String from, String to) {
    const rates = {
      'Nm': 1.0,
      'Lb-ft': 1.35582,
      'Kilogram-meters': 9.80665,
      'dyncm': 0.0000001,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Luminance - ALL RATES IN CANDELA/M²
  static double convertLuminance(double value, String from, String to) {
    const rates = {
      'Candela/m³': 1.0,
      'Foot-lamberts': 3.426,
      'Nits': 1.0,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Density - ALL RATES IN KG/M³
  static double convertDensity(double value, String from, String to) {
    const rates = {
      'kg/m³': 1.0,
      'G/cc': 1000.0,
      'lb/ft³': 16.0185,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Voltage - ALL RATES IN VOLTS
  static double convertVoltage(double value, String from, String to) {
    const rates = {
      'Volts': 1.0,
      'Millivolts': 0.001,
      'Kilovolts': 1000.0,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Resistance - ALL RATES IN OHMS
  static double convertResistance(double value, String from, String to) {
    const rates = {
      'Ohms': 1.0,
      'Kiloohms': 1000.0,
      'Megaohms': 1000000.0,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Capacitance - ALL RATES IN FARADS
  static double convertCapacitance(double value, String from, String to) {
    const rates = {
      'Farads': 1.0,
      'Microfarads': 0.000001,
      'Nanofarads': 0.000000001,
      'Picofarads': 0.000000000001,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Inductance - ALL RATES IN HENRYS
  static double convertInductance(double value, String from, String to) {
    const rates = {
      'Henrys': 1.0,
      'Millihenrys': 0.001,
      'Microhenrys': 0.000001,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Magnetic Flux - ALL RATES IN WEBER
  static double convertMagneticFlux(double value, String from, String to) {
    const rates = {
      'Weber': 1.0,
      'Maxwell': 0.00000001,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Magnetic Field Strength - ALL RATES IN TESLA
  static double convertMagneticFieldStrength(double value, String from, String to) {
    const rates = {
      'Tesla': 1.0,
      'Gauss': 0.0001,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Radiation Dose - ALL RATES IN GRAY
  static double convertRadiationDose(double value, String from, String to) {
    const rates = {
      'Gray': 1.0,
      'Sievert': 1.0, // Equivalent for practical purposes
      'Rad': 0.01,
      'Rem': 0.01,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Radioactivity - ALL RATES IN BECQUEREL
  static double convertRadioactivity(double value, String from, String to) {
    const rates = {
      'Becquerel': 1.0,
      'Curie': 37000000000.0,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Luminous Flux - ALL RATES IN LUMENS
  static double convertLuminousFlux(double value, String from, String to) {
    const rates = {
      'Lumens': 1.0,
      'Candela': 12.566, // 1 candela ≈ 4π lumens (sphere)
      'Foot-lamberts': 3.426,
    };
    return value * rates[from]! / rates[to]!;
  }

  // Acceleration - ALL RATES IN M/S²
  static double convertAcceleration(double value, String from, String to) {
    const rates = {
      'm/s²': 1.0,
      'ft/s²': 0.3048,
      'G-force': 9.80665,
    };
    return value * rates[from]! / rates[to]!;
  }
}