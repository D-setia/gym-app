import 'package:flutter/material.dart';
import 'package:gym_app/logic/models/workout.dart';
import 'package:gym_app/presentation/workout_page/edit_exercise_dialog.dart';

Future<int?> showEditExerciseDialog(
    {required BuildContext context,
    required Exercise exercise,
    required Function(int) deleteExercise,
    required int index,
    required Function(int, Exercise) modifyExercise}) async {
  return showDialog<int>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return EditExerciseDialog(
          exercise: exercise,
          deleteExercise: deleteExercise,
          index: index,
          modifyExercise: modifyExercise);
    },
  );
}
