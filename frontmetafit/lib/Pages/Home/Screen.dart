import 'package:flutter/material.dart';
import 'package:frontmetafit/Pages/Home/homePage.dart';
import 'package:frontmetafit/Pages/Home/routinesPage.dart';
import 'package:frontmetafit/Pages/Home/progressPage.dart';
import 'package:frontmetafit/Pages/Home/settingsPage.dart';
import 'package:frontmetafit/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Screen extends StatefulWidget {
  static const String routeName = '/screen';
  const Screen({super.key});

  @override
  State<Screen> createState() => _forgottenPasswordState();
}

// ignore: camel_case_types
class _forgottenPasswordState extends State<Screen> {
  SupabaseClient supabase = Supabase.instance.client;
  String? userId;

  initState() {
    userId = supabase.auth.currentUser?.id;
    super.initState();
  }

  dynamic index = 0;
  final List<Widget> _children = [
    HomePage(),
    RoutinesPage(),
    ProgressPage(),
    SettingsPage(),
  ];

  Future<String> _fetchUserName() async {
    final response = await Supabase.instance.client
        .from('users')
        .select('full_name')
        .eq('id', userId!)
        .single();
    return response['full_name'] as String;
  }

  @override
  Widget build(BuildContext context) {
    // Add this line to call the super method
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
                    child: FutureBuilder<String>(
                      future: _fetchUserName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading...',
                              style: TextStyles.subtitle(context));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            'Welcome back,\n${snapshot.data}',
                            style: TextStyles.subtitle(context),
                            overflow: TextOverflow.ellipsis,
                          );
                        }
                      },
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
