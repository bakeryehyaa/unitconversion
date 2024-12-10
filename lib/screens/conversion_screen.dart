import 'package:flutter/material.dart';
import '../utils/conversion_rules.dart';

class ConversionScreen extends StatefulWidget {
  final String type;

  const ConversionScreen({super.key, required this.type});

  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  String fromUnit = '';
  String toUnit = '';
  double input = 0.0;
  double? result;

  late Map<String, Map<String, double>>? conversionMap;
  late Map<String, Function(double)>? toCelsiusMap;
  late Map<String, Function(double)>? fromCelsiusMap;

  @override
  void initState() {
    super.initState();
    if (widget.type == "Length") {
      conversionMap = lengthConversion;
    } else if (widget.type == "Weight") {
      conversionMap = weightConversion;
    } else if (widget.type == "Temperature") {
      conversionMap = null;
      toCelsiusMap = temperatureConversionToCelsius;
      fromCelsiusMap = temperatureConversionFromCelsius;
    } else if (widget.type == "Watt") {
      conversionMap = wattConversion;
    }
    fromUnit = conversionMap?.keys.first ?? toCelsiusMap!.keys.first;
    toUnit = conversionMap?.keys.first ?? fromCelsiusMap!.keys.first;
  }

  void convert() {
    if (widget.type == "Temperature" &&
        toCelsiusMap != null &&
        fromCelsiusMap != null) {
      double valueInCelsius = toCelsiusMap![fromUnit]!(input);
      setState(() {
        result = fromCelsiusMap![toUnit]!(valueInCelsius);
      });
    } else if (conversionMap != null && conversionMap![fromUnit] != null) {
      double conversionFactor = conversionMap![fromUnit]![toUnit] ?? 1.0;
      setState(() {
        result = input * conversionFactor;
      });
    }
  }

  void clear() {
    setState(() {
      input = 0.0;
      result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.type} Converter"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter value",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (value) {
                input = double.tryParse(value) ?? 0.0;
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: fromUnit,
                    decoration: InputDecoration(
                      labelText: "From",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        fromUnit = value!;
                      });
                    },
                    items: (conversionMap?.keys.toList() ??
                            toCelsiusMap!.keys.toList())
                        .map((unit) => DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: toUnit,
                    decoration: InputDecoration(
                      labelText: "To",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        toUnit = value!;
                      });
                    },
                    items: (conversionMap?.keys.toList() ??
                            fromCelsiusMap!.keys.toList())
                        .map((unit) => DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: convert,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Convert"),
            ),
            const SizedBox(height: 16),
            if (result != null)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Result: ${result?.toStringAsFixed(2)} $toUnit",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: clear,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Clear"),
            ),
          ],
        ),
      ),
    );
  }
}
