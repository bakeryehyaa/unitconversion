import 'package:flutter/material.dart';
import 'conversion_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> conversionTypes = [
    {"name": "Length", "icon": Icons.straighten},
    {"name": "Weight", "icon": Icons.monitor_weight},
    {"name": "Temperature", "icon": Icons.thermostat},
    {"name": "Watt", "icon": Icons.electrical_services},
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unit Converter"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: conversionTypes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final type = conversionTypes[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: InkWell(
                onTap: () {
                  // Navigate to ConversionScreen with the selected type
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ConversionScreen(type: type["name"]),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(type["icon"], size: 40, color: Colors.blue),
                    const SizedBox(height: 10),
                    Text(
                      type["name"],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
