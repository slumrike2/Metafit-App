import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        canvasColor: Colors.blue,
        scaffoldBackgroundColor: Colors.blue,
        textTheme: const TextTheme(
          // Added const
          //* Estilo de los Textos
          //! DEFINIR EN TERMINOS DE SIZEW
          bodyMedium: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      home: Scaffold(
        body: Center(
          child: Builder(
            // Added Builder to get new context
            builder: (context) {
              return Text('Hello World!',
                  style: Theme.of(context).textTheme.bodyMedium);
            },
          ),
        ),
      ),
    );
  }
}
