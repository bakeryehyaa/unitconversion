Map<String, Map<String, double>> lengthConversion = {
  "meters": {"kilometers": 0.001, "centimeters": 100.0},
  "kilometers": {"meters": 1000.0, "centimeters": 100000.0},
  "centimeters": {"meters": 0.01, "kilometers": 0.00001},
};

Map<String, Map<String, double>> weightConversion = {
  "kilograms": {"grams": 1000.0, "pounds": 2.20462},
  "grams": {"kilograms": 0.001, "pounds": 0.00220462},
  "pounds": {"kilograms": 0.453592, "grams": 453.592},
};

Map<String, Function(double)> temperatureConversionToCelsius = {
  "Celsius": (value) => value,
  "Fahrenheit": (value) => (value - 32) * 5 / 9,
  "Kelvin": (value) => value - 273.15,
};
Map<String, Function(double)> temperatureConversionFromCelsius = {
  "Celsius": (value) => value,
  "Fahrenheit": (value) => (value * 9 / 5) + 32,
  "Kelvin": (value) => value + 273.15,
};
Map<String, Map<String, double>> wattConversion = {
  "watts": {"kilowatts": 0.001, "megawatts": 0.000001},
  "kilowatts": {"watts": 1000.0, "megawatts": 0.001},
  "megawatts": {"watts": 1000000.0, "kilowatts": 1000.0},
};
