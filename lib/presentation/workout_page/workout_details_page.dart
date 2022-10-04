import 'package:flutter/material.dart';
import 'package:gym_app/constants/exercise_options.dart';
import 'package:gym_app/constants/strings.dart';
import 'package:gym_app/data/workouts.dart';
import 'package:gym_app/logic/models/workout.dart';
import 'package:gym_app/presentation/my_app_bar.dart';
import 'package:gym_app/presentation/workout_page/exercise_helpers.dart';
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
    loadExercises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackPress,
      child: Scaffold(
        appBar: myAppBar(
            title: widget.workoutTitle,
            showEditButton: true,
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
                    key: Key("$index"),
                    exercise: _exercises[index],
                    index: index,
                    isEditModeActive: isEditModeActive,
                    deleteExercise: deleteExercise,
                    modifyExercise: modifyExercise,
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
        floatingActionButton: isEditModeActive
            ? FloatingActionButton(
                onPressed: () {
                  showEditExerciseDialog(
                      context: context,
                      exercise: Exercise(name: "", type: DEFAULT_TYPE),
                      deleteExercise: (index) {},
                      modifyExercise: (index, exercise) => setState(() {
                            _exercises.add(exercise);
                        }),
                      index: _exercises.length - 1);
                },
                child: const Icon(Icons.add),
              )
            : Container(),
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

  deleteExercise(int index) {
    setState(() {
      _exercises.removeAt(index);
    });
  }

  modifyExercise(int index, Exercise exercise) {
    setState(() {
      _exercises[index] = exercise;
    });
  }

  Future<bool> handleBackPress() async {
    if (isEditModeActive) {
      setState(() {
        isEditModeActive = false;
      });
      return false;
    } else {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _workouts[widget.dayNo - 1].exercises = _exercises;
      _prefs.setString(WORKOUTS, workoutListToJson(_workouts));
      return true;
    }
  }
}
