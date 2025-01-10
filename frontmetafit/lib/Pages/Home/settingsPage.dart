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
      body: Column(
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    supabase.auth.signOut();
                    Navigator.pushReplacementNamed(
                        context, LoginPage.routeName);
                  },
                  child: Text('Sign Out'))),
          Center(
              child: ElevatedButton(
                  onPressed: () async {
                    final response = await http.get(
                        Uri.parse('https://t8vf9bk0-8000.use2.devtunnels.ms/'));
                    if (response.statusCode == 200) {
                      print('Response data: ${response.body}');
                    } else {
                      print('Failed to load data');
                    }
                  },
                  child: Text(
                    'Test',
                    style: TextStyles.headline0(context),
                  ))),
        ],
      ),
    );
  }
}
