import 'package:flutter/material.dart';
import 'package:frontmetafit/Pages/Home/homePage.dart';
import 'package:frontmetafit/Pages/Home/routinesPage.dart';
import 'package:frontmetafit/Pages/Home/progressPage.dart';
import 'package:frontmetafit/Pages/Home/settingsPage.dart';
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
  final List<Widget> _children = [
    HomePage(),
    RoutinesPage(),
    ProgressPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[index],
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
