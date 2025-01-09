import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/ConfirmButton.dart';
import 'package:frontmetafit/Components/ExcersiceExpanded.dart';

class Doroutine extends StatefulWidget {
  const Doroutine({super.key, required this.name, required this.description});

  static const String routeName = '/DoRoutine';

  final String name;
  final String description;

  @override
  State<Doroutine> createState() => _DoroutineState();
}

class _DoroutineState extends State<Doroutine> {
  String selectedExercise = '';
  int currentPage = 0;
  int remainingTime = 0;
  Timer? _timer;
  final PageController _pageController = PageController();
  bool isPaused = true;

  void selectExercise(String name) {
    setState(() {
      selectedExercise = name;
    });
  }

  void startTimer() {
    setState(() {
      isPaused = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          isPaused = true;
          // Add logic to handle end of timer if needed
        }
      });
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() {
      isPaused = true;
    });
  }

  void nextPage() {
    if (currentPage < 3) {
      // Adjust the condition based on the number of pages
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setTimerForCurrentPage();
    }
  }

  void setTimerForCurrentPage() {
    final currentExercise = (currentPage == 0)
        ? Excersiceexpanded(
            name: 'dumbell alternate bicep curl',
            description: 'no se que poner',
            difficulty: 'dificil',
            equipment: 'equipment',
            muscles: 'muscles',
            series: 4,
            reps: 12,
            time: 30)
        : (currentPage == 1)
            ? Excersiceexpanded(
                name: 'push up',
                description: 'no se que poner',
                difficulty: 'medio',
                equipment: 'none',
                muscles: 'chest',
                series: 3,
                reps: 15,
                time: 3)
            : Excersiceexpanded(
                name: 'squat',
                description: 'no se que poner',
                difficulty: 'facil',
                equipment: 'none',
                muscles: 'legs',
                series: 4,
                reps: 20,
                time: 1);
    setState(() {
      remainingTime = currentExercise.time;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name), // Use the widget's name property
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Time: ${remainingTime}s'),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
                setTimerForCurrentPage();
              });
            },
            children: [
              Excersiceexpanded(
                  name: 'dumbell alternate bicep curl',
                  description: 'no se que poner',
                  difficulty: 'dificil',
                  equipment: 'equipment',
                  muscles: 'muscles',
                  series: 4,
                  reps: 12,
                  time: 30),
              Excersiceexpanded(
                  name: 'push up',
                  description: 'no se que poner',
                  difficulty: 'medio',
                  equipment: 'none',
                  muscles: 'chest',
                  series: 3,
                  reps: 15,
                  time: 120),
              Excersiceexpanded(
                  name: 'squat',
                  description: 'no se que poner',
                  difficulty: 'facil',
                  equipment: 'none',
                  muscles: 'legs',
                  series: 4,
                  reps: 20,
                  time: 60),
              // Add more Excersiceexpanded widgets as needed
            ],
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sizew * 0.25),
              child: ConfirmButton(
                  text: remainingTime == 0
                      ? 'Next'
                      : (isPaused ? 'Start' : 'Pause'),
                  onPressed: () {
                    if (remainingTime == 0) {
                      nextPage();
                    } else if (isPaused) {
                      startTimer();
                    } else {
                      pauseTimer();
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
