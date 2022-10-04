import 'package:flutter/material.dart';
import 'package:gym_app/constants/strings.dart';
import 'package:gym_app/logic/helpers.dart';
import 'package:gym_app/logic/models/workout.dart';
import 'dart:math' as math;

import 'package:gym_app/presentation/workout_page/edit_exercise_dialog.dart';
import 'package:gym_app/presentation/workout_page/exercise_helpers.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  final int? index;
  final bool isEditModeActive;
  final Function(int, Exercise)? modifyExercise;
  final Function(int)? deleteExercise;
  const ExerciseTile(
      {required this.exercise,
      required this.isEditModeActive,
      this.index,
      this.deleteExercise,
      this.modifyExercise,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PhysicalModel(
        color: Theme.of(context).secondaryHeaderColor,
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
          onTap: () => editExercise(context),
          // onDoubleTap: () => handleOnExerciseTap(),
          child: ListTile(
            leading: Icon(
              getIcon(exercise.type),
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
                        exercise.type != CARDIO
                            ? exercise.sets.toString()
                            : exercise.durations![0],
                        style: const TextStyle(fontSize: 30),
                      ),
                      Text(
                        exercise.type != CARDIO ? "sets" : "min:sec",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void editExercise(BuildContext context) async {
    if (isEditModeActive) {
      await showEditExerciseDialog(
          context: context,
          index: index!,
          exercise: exercise,
          modifyExercise: modifyExercise!,
          deleteExercise: deleteExercise!);
    }
    //TODO: implement
  }

  List<Widget>? getSubtitle() {
    List<Widget> subtitle = [];
    if (exercise.sets == 0) return subtitle;

    String reps = REPS;
    String dur = DURATION;
    String weights = WEIGHTS;

    if (exercise.durations != null && exercise.durations!.isNotEmpty) {
      if (exercise.type == CARDIO && exercise.sets == 1) {
      } else {
        for (int i = 0; i < exercise.durations!.length; i++) {
          if (i != 0) dur += ", ";
          dur += exercise.durations![i];
        }

        if (exercise.reps != null && exercise.reps!.isNotEmpty) {
          for (int i = 0; i < exercise.reps!.length; i++) {
            String rep = exercise.reps![i].toString();
            while (rep.length < exercise.durations![i].length) {
              rep = " $rep";
            }
            if (i != 0) rep = ", $rep";
            reps += rep;
          }
          subtitle.add(Text(reps));
        }
        if (exercise.weights != null && exercise.weights!.isNotEmpty) {
          for (int i = 0; i < exercise.weights!.length; i++) {
            String wt = exercise.weights![i].toString();
            while (wt.length < exercise.durations![i].length) {
              wt = " $wt";
            }
            if (i != 0) wt = ", $wt";
            weights += wt;
          }
          subtitle.add(Text(weights));
        }
        subtitle.add(Text(dur));
      }
    } else {
      if (exercise.reps != null && exercise.reps!.isNotEmpty) {
        for (int i = 0; i < exercise.reps!.length; i++) {
          if (i != 0) reps += ", ";
          if (exercise.reps![i].length == 1 && exercise.reps![i] != "0") {
            reps += "0";
          }
          reps += exercise.reps![i].toString();
        }
        subtitle.add(Text(reps));
      }

      if (exercise.weights != null && exercise.weights!.isNotEmpty) {
        for (int i = 0; i < exercise.weights!.length; i++) {
          if (i != 0) weights += ", ";
          if (exercise.weights![i].length == 1 && exercise.weights![i] != "0") {
            weights += "0";
          }
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
}
