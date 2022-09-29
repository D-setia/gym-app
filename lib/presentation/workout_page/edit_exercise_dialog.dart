import 'package:flutter/material.dart';
import 'package:gym_app/logic/models/workout.dart';
import 'package:gym_app/presentation/workout_page/alert_dialog_body.dart';

Widget editExerciseDialog(
    {required BuildContext context,
    required Exercise exercise,
    required int index,
    required Function(int, Exercise) modifyExercise,
  required Function(int) deleteExercise}) {
  return AlertDialog(
    title: Text("asdgf"),
    content: EditExerciseAlertDialogBody(exercise: exercise, index:  index, deleteExercise:  deleteExercise, modifyExercise: modifyExercise,),
    actionsAlignment: MainAxisAlignment.spaceBetween,
    actions: <Widget>[
      TextButton(
        child: const Text('Delete'),
        onPressed: () =>
            confirmDelete(context: context, deleteExercise: deleteExercise)
                .then((performDelete) {
          if (performDelete == true) Navigator.of(context).pop();
        }),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ],
  );
}

Future<bool?> confirmDelete(
    {required BuildContext context, required Function(int) deleteExercise}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this exercise?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                deleteExercise(0); //TODO: implement
                Navigator.pop(context, true);
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ))
        ],
      );
    },
  );
}
