import 'package:flutter/material.dart';
import 'package:frontmetafit/Pages/forgottenPassword.dart';
import 'const.dart';
import 'Pages/loginPage.dart';
import 'Pages/registerPage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  String supabaseUrl = dotenv.env['SUPABASE_URL']!;
  String supabaseKey = dotenv.env['SUPABASE_ANON_KEY']!;

  if (supabaseUrl.isEmpty || supabaseKey.isEmpty) {
    throw Exception('Missing Supabase credentials');
  }

  await Supabase.initialize(
      url: supabaseUrl, anonKey: supabaseKey, debug: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        focusColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.primary,
        useMaterial3: true,
      ),
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        registerPage.routeName: (context) => const registerPage(),
        forgottenPassword.routeName: (context) => const forgottenPassword(),
      },
      initialRoute: LoginPage.routeName,
    );
  }
}
