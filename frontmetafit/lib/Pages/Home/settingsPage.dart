import 'package:flutter/material.dart';
import 'package:frontmetafit/Pages/Inicio%20de%20seion/loginPage.dart';
import 'package:frontmetafit/const.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SupabaseClient supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(8),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: settingsOptions.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(settingsOptions[index]['icon']),
                      title: Text(
                        settingsOptions[index]['title'],
                        style: TextStyles.headline2(context),
                      ),
                      onTap: () {
                        settingsOptions[index]['action'](context);
                      },
                    ),
                    Divider(
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  final List<Map<String, dynamic>> settingsOptions = [
    {
      'title': 'Account',
      'icon': Icons.account_circle,
      'action': (BuildContext context) {},
    },
    {
      'title': 'Personal',
      'icon': Icons.person,
      'action': (BuildContext context) {},
    },
    {
      'title': 'Workouts',
      'icon': Icons.fitness_center,
      'action': (BuildContext context) async {
        // print('Getting workouts');
        // final response = await http.get(Uri.parse(
        //     'https://xjl0vrff-8000.use.devtunnels.ms/gen_routine?user_uid=${Supabase.instance.client.auth.currentUser!.id}'));
      },
    },
    {
      'title': 'Privacy and Security',
      'icon': Icons.lock,
      'action': (BuildContext context) {},
    },
    {
      'title': 'About',
      'icon': Icons.info,
      'action': (BuildContext context) {},
    },
    {
      'title': 'Logout',
      'icon': Icons.logout,
      'action': (BuildContext context) async {
        await Supabase.instance.client.auth.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
    },
    // Add more options here if needed
  ];
}
