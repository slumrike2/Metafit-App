import 'package:flutter/material.dart';
import 'package:frontmetafit/Pages/Home/Screen.dart';
import 'package:frontmetafit/Pages/Routine/doRoutine.dart';
import 'package:frontmetafit/Pages/Routine/routinePreview.dart';

import 'Pages/Inicio de seion/forgottenPassword.dart';
import 'const.dart';
import 'Pages/Inicio de seion/loginPage.dart';
import 'Pages/Inicio de seion/registerPage.dart';
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
      title: 'Metafit App',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: AppColors.secondary, // Header background color
          onPrimary: AppColors.complementary, // Header text color
          surface: AppColors.primary, // Background color
          onSurface: AppColors.complementary, // Text color
        ),
        scaffoldBackgroundColor: AppColors.primary, // App background color
        dialogBackgroundColor: AppColors.primary, // Dialog background color
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        registerPage.routeName: (context) => const registerPage(),
        forgottenPassword.routeName: (context) => const forgottenPassword(),
        Screen.routeName: (context) => const Screen(),
        Routinepreview.routeName: (context) => const Routinepreview(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == Doroutine.routeName) {
          final args = settings.arguments as Map<String, String>?;
          return MaterialPageRoute(
            builder: (context) {
              return Doroutine(
                name: args?['name'] ?? 'No Name',
                description: args?['description'] ?? 'No Description',
              );
            },
          );
        }
        return null;
      },
      initialRoute: LoginPage.routeName,
      
    );
  }
}
