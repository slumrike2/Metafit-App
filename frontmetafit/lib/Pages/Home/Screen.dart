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
    final sizeh = MediaQuery.of(context).size.height;
    final sizew = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          () {
            switch (index) {
              case 0:
                return '';
              case 1:
                return 'Routines';
              case 2:
                return 'Progress';
              case 3:
                return 'Settings';
              default:
                return 'Home';
            }
          }(),
          style: TextStyles.headline1(context),
        ),
        actions: index != 3
            ? [
                IconButton(
                  icon: Icon(Icons.person_outline),
                  onPressed: () {},
                  iconSize: sizeh * 0.05,
                ),
                IconButton(
                  icon: Icon(Icons.notifications_outlined),
                  onPressed: () {},
                  iconSize: sizeh * 0.05,
                ),
              ]
            : [],
        toolbarHeight: sizeh * 0.075,
        flexibleSpace: Container(
          child: index == 0
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: sizew * 0.7,
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Welcome back,\nJesus Alejandro',
                      style: TextStyles.subtitle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              : null,
        ),
      ),
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
