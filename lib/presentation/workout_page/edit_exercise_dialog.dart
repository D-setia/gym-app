import 'package:flutter/material.dart';
import 'package:gym_app/logic/models/workout.dart';

AlertDialog editExerciseDialog(BuildContext context, Exercise exercise) {
  return AlertDialog(
    title: Text(exercise.name),
    content: SingleChildScrollView(
      child: ListBody(
        children: const <Widget>[
          Text('This is a demo alert dialog.'),
          Text('Would you like to approve of this message?'),
        ],
      ),
    ),
    actionsAlignment: MainAxisAlignment.spaceBetween,
    actions: <Widget>[
      TextButton(
        child: const Text('Delete'),
        onPressed: () => confirmDelete(context),
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
Future<void> confirmDelete(BuildContext context){
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(title: const Text("Confirm Delete"), content: const Text("Are you sure you want to delete this exercise?"), );
      },
    );
}
