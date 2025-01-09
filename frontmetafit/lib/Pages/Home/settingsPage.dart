import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/SumaryWidget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SumaryWidget(
          data: [
            ElementosSumary(name: 'Name', value: 20),
            ElementosSumary(
                name: 'Email', value: 50), // Assuming 0 for empty value
            ElementosSumary(name: 'Shoulders', value: 25),
            ElementosSumary(name: 'Weight', value: 75),
            ElementosSumary(name: 'Height', value: 90),
          ],
        ),
      ),
    );
  }
}
