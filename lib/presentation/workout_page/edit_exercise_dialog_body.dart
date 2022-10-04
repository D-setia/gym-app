import 'package:flutter/material.dart';
import 'package:gym_app/constants/exercise_options.dart';
import 'package:gym_app/constants/strings.dart';
import 'package:gym_app/constants/styles.dart';
import 'package:gym_app/logic/helpers.dart';

Widget selectExerciseTypeRow(
    {required String type, required Function(String?) onChanged}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(0.0, 2.0, 4.0, 2.0),
        child: Text(
          "Type : ",
          style: editExerciseDialogHeadingStyle,
        ),
      ),
      DropdownButton(
        iconSize: 30,
        itemHeight: 55,
        elevation: 0,
        value: type,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: TYPES.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    getIcon(item),
                    size: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      item,
                      style: exerciseTypeNameStyle,
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        // (String? newValue) {
        //   setState(() {
        //     _type = newValue!;
        //   });
        //   widget.setType(_type);
        // },
      ),
    ],
  );
}

Widget selectNumberOfSetsRow(
    {required int sets, required Function(int?) onChanged}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(0.0, 2.0, 4.0, 2.0),
        child: Text(
          "Sets : ",
          style: editExerciseDialogHeadingStyle,
        ),
      ),
      DropdownButton(
        iconSize: 30,
        itemHeight: 55,
        elevation: 0,
        value: sets,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: SETS.map((int item) {
          return DropdownMenuItem(
            value: item,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "$item",
                style: exerciseTypeNameStyle,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    ],
  );
}

Widget modifyRepsRow(
    {required int sets, required List<TextEditingController> repsControllers}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(0.0, 2.0, 4.0, 2.0),
        child: Text(
          "Reps : ",
          style: editExerciseDialogHeadingStyle,
        ),
      ),
      SizedBox(
          height: 50,
          width: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sets,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: TextField(
                      controller: repsControllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: repsIpDecor,
                    )),
              );
            }),
          ))
    ],
  );
}

Widget selectWtsVsDurationsSwitch(
    {required bool specifyDurations, required Function(bool) onChanged}) {
  return Row(
    children: [
      const Text("Weights"),
      Switch(
        activeColor: Colors.blue,
        inactiveThumbColor: Colors.green,
        inactiveTrackColor: Colors.lightGreen,
        value: specifyDurations,
        onChanged: onChanged,
      ),
      const Text("Durations")
    ],
  );
}

Widget selectWtsDurationsRow({
  required bool specifyDurations,
  required int sets,
  required List<TextEditingController> wtsControllers,
  required List<TextEditingController> durationsControllers,
}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 2.0, 4.0, 2.0),
        child: Text(
          specifyDurations ? "Duration: " : "Weights: ",
          style: editExerciseDialogHeadingStyle,
        ),
      ),
      SizedBox(
          height: 50,
          width: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sets,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: TextField(
                      controller: specifyDurations
                          ? durationsControllers[index]
                          : wtsControllers[index],
                      keyboardType: specifyDurations
                          ? TextInputType.datetime :TextInputType.number,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration:
                          specifyDurations ? durationsIpDecor : wtsIpDecor,
                    )),
              );
            }),
          ))
    ],
  );
}

List<Widget> dialogActionButtons(
    {required VoidCallback onDelete,
    required VoidCallback onSave,
    required VoidCallback onCancel}) {
  return <Widget>[
    TextButton(
      onPressed: onDelete,
      child: const Text('Delete'),
    ),
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        )
      ],
    ),
  ];
}

Widget confirmCancelDialog({required VoidCallback onBack, required VoidCallback onCancelConfirm}){
  return AlertDialog(
          title: const Text("Confirm Cancel"),
          content: const Text(
              "Are you sure you want to cancel? Any changes made will be discarded."),
          actions: [
            TextButton(
                onPressed: onBack,
                child: const Text("Back")),
            TextButton(
                onPressed: onCancelConfirm,
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        );
}

Widget confirmDeleteDialog({required VoidCallback onCancel, required VoidCallback onDeleteConfirm}){
  return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this exercise?"),
          actions: [
            TextButton(
                onPressed: onCancel,
                child: const Text("Cancel")),
            TextButton(
                onPressed: onDeleteConfirm,
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        );
}
