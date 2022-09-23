import 'package:flutter/material.dart';
import 'package:gym_app/constants/strings.dart';
import 'package:gym_app/logic/models/workout.dart';
import 'dart:math' as math;

import 'package:gym_app/presentation/workout_page/edit_exercise_dialog.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  final bool isEditModeActive;
  const ExerciseTile(
      {required this.exercise, required this.isEditModeActive, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
          onTap: handleOnExerciseTap,
          onDoubleTap: () => editExercise(context),
          child: ListTile(
            leading: Icon(
              getIcon(),
              size: 40,
            ),
            title: Text(
              exercise.name,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: (getSubtitle() == null)
                ? null
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: getSubtitle()!),
            trailing: isEditModeActive
                ? const Icon(
                    Icons.drag_handle,
                    size: 30,
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        exercise.duration == null
                            ? exercise.sets.toString()
                            : exercise.duration!,
                        style: const TextStyle(fontSize: 30),
                      ),
                      Text(
                        exercise.duration == null ? "sets" : "mins",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  IconData? getIcon() {
    switch (exercise.type) {
      case MACHINE:
        return Icons.settings;
      case DUMBBELL:
        return Icons.fitness_center;
      case CABLE:
        return Icons.cable;
      case CARDIO:
        return Icons.directions_run_rounded;
      case ABS:
        return Icons.airline_seat_flat_angled;
      case RT:
        return Icons.cable;
      case MISC:
        return Icons.sports_gymnastics;
      case CALISTHENICS:
        return Icons.sports_mma;
      default:
        return Icons.question_mark;
    }
  }

  void editExercise(BuildContext context) async {
    if (isEditModeActive)
      int resp = await showEditExerciseDialog(context) ?? 400;
    //TODO: implement
  }

  List<Widget>? getSubtitle() {
    List<Widget> subtitle = [];
    if (exercise.sets == 0) return subtitle;

    String reps = REPS;
    String dur = DURATION;
    String weights = WEIGHTS;

    if (exercise.duration != null) {
      for (int i = 0; i < exercise.duration!.length; i++) {
        if (i != 0) dur += ", ";
        reps += exercise.duration![i];
      }

      if (exercise.reps != null) {
        for (int i = 0; i < exercise.reps!.length; i++) {
          String rep = exercise.reps![i].toString();
          while (rep.length < exercise.duration![i].length) {
            rep = " $rep";
          }
          if (i != 0) rep = ", $rep";
          reps += rep;
        }
        subtitle.add(Text(reps));
      }
      if (exercise.weights != null) {
        for (int i = 0; i < exercise.weights!.length; i++) {
          String wt = exercise.weights![i].toString();
          while (wt.length < exercise.duration![i].length) {
            wt = " $wt";
          }
          if (i != 0) wt = ", $wt";
          weights += wt;
        }
        subtitle.add(Text(weights));
      }
      subtitle.add(Text(dur));
    } else {
      if (exercise.reps != null) {
        for (int i = 0; i < exercise.reps!.length; i++) {
          if (i != 0) reps += ", ";
          if (exercise.reps![i] < 10) reps += " ";
          reps += exercise.reps![i].toString();
        }
        subtitle.add(Text(reps));
      }

      if (exercise.weights != null) {
        for (int i = 0; i < exercise.weights!.length; i++) {
          if (i != 0) weights += ", ";
          if (exercise.weights![i] < 10) weights += " ";
          weights += exercise.weights![i].toString();
        }
        subtitle.add(Text(weights));
      }
    }
    return subtitle;
  }

  int getMaxLen(int? len1, int? len2) {
    if (len1 == null && len2 == null) {
      return 0;
    } else if (len1 != null && len2 == null) {
      return len1;
    } else if (len1 == null && len2 != null) {
      return len2;
    } else {
      return math.max(len1!, len2!);
    }
  }

  void handleOnExerciseTap() {}

  Future<int?> showEditExerciseDialog(BuildContext context) async {
    return showDialog<int>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return editExerciseDialog(context, exercise);
      },
    );
  }
}
