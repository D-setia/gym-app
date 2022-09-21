import 'package:flutter/material.dart';
import 'package:gym_app/logic/models/workout.dart';
import 'package:gym_app/presentation/my_app_bar.dart';

class WorkoutDetailsPage extends StatefulWidget {
  final String workoutTitle;
  const WorkoutDetailsPage({required this.workoutTitle, super.key});

  @override
  State<WorkoutDetailsPage> createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  bool isEditModeActive = false;
  List<Exercise> exercises = [];

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
      body: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return Container();
          }),
    );
  }

  void onEditButtonClick() => setState(() {
        isEditModeActive = !isEditModeActive;
      });

  void loadExercises() {}
}
