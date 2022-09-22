import 'package:flutter/material.dart';
import 'package:gym_app/constants/strings.dart';
import 'package:gym_app/data/workouts.dart';
import 'package:gym_app/logic/models/workout.dart';
import 'package:gym_app/presentation/my_app_bar.dart';
import 'package:gym_app/presentation/workout_page/exercise_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutDetailsPage extends StatefulWidget {
  final String workoutTitle;
  final int dayNo;
  const WorkoutDetailsPage(
      {required this.workoutTitle, required this.dayNo, super.key});

  @override
  State<WorkoutDetailsPage> createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  bool isEditModeActive = false;
  List<Exercise> _exercises = [];
  List<Workout> _workouts = [];

  @override
  void initState() {
    // TODO: implement initState
    loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          title: widget.workoutTitle,
          onEditButtonClick: onEditButtonClick,
          isEditModeActive: isEditModeActive),
      body: !isEditModeActive
          ? ListView.builder(
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                return ExerciseTile(
                  exercise: _exercises[index],
                  isEditModeActive: isEditModeActive,
                );
              })
          : ReorderableListView.builder(
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                return ExerciseTile(
                  key: Key('$index'),
                  exercise: _exercises[index],
                  isEditModeActive: isEditModeActive,
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final Exercise item = _exercises.removeAt(oldIndex);
                _exercises.insert(newIndex, item);
              },
            ),
    );
  }

  void onEditButtonClick() => setState(() {
        isEditModeActive = !isEditModeActive;
      });

  void loadExercises() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? workoutsJson = prefs.getString(WORKOUTS);

    if (workoutsJson == null) {
      _workouts = defaultWorkouts;
    } else {
      _workouts = workoutListFromJson(workoutsJson);
    }

    setState(() {
      _exercises = _workouts[widget.dayNo - 1].exercises;
    });
  }
}
