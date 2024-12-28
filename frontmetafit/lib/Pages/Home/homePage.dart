import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/RoutineWidget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: RoutineWidget(
            difficulty: 'hard',
            cantExercises: 2,
            equipment: 'none',
            name: 'Workout',
            description:
                'Aqui va la descripcion del entrenamiento que deberia ser mas larga para ver como se ve en la pantalla y si se ajusta bien al espacio que se le asigno en el widget',
            percentage: '95%'),
      ),
    );
  }
}
