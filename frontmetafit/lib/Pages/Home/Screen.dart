import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';

class Screen extends StatefulWidget {
  static const String routeName = '/pantalla';
  const Screen({Key? key});

  @override
  State<Screen> createState() => _forgottenPasswordState();
}

// ignore: camel_case_types
class _forgottenPasswordState extends State<Screen> {
  dynamic index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back'))),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.complementary,
          unselectedItemColor: AppColors.secondary,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Routines',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ]),
    );
  }
}
