import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/HistoryWorkOutWidget.dart';
import 'package:frontmetafit/Components/RoutineWidget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            RoutineWidget(
                difficulty: 'hard',
                cantExercises: 2,
                equipment: 'none',
                name: 'Shoulder Workout ',
                description:
                    'Aqui va la descripcion del entrenamiento que deberia ser mas larga para ver como se ve en la pantalla y si se ajusta bien al espacio que se le asigno en el widget,quiero saber que pasa si me sobrepaso de esta mundicia',
                percentage: '95%'),
            Historyworkoutwidget()
          ],
        ),
      ),
    );
  }
}
