import 'package:flutter/material.dart';
import 'package:gym_app/constants/strings.dart';
import 'package:gym_app/logic/helpers.dart';
import 'package:gym_app/logic/models/workout.dart';

class EditExerciseAlertDialogBody extends StatefulWidget {
  final int index;
  final Exercise exercise;
  final Function(int, Exercise) modifyExercise;
  final Function(int) deleteExercise;
  const EditExerciseAlertDialogBody(
      {required this.exercise,
      required this.index,
      required this.deleteExercise,
      required this.modifyExercise,
      super.key});

  @override
  State<EditExerciseAlertDialogBody> createState() =>
      _EditExerciseAlertDialogBodyState();
}

class _EditExerciseAlertDialogBodyState
    extends State<EditExerciseAlertDialogBody> {
  late int _sets;
  int prevSets = 0;
  final TextEditingController _nameController = TextEditingController();
  late String type;
  List<TextEditingController> durationsControllers = [];
  List<TextEditingController> repsControllers = [];
  List<TextEditingController> wtsControllers = [];

  @override
  void initState() {
    initCurrVals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: [
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                 DropdownButton(
                  value: type,
                  icon: const Icon(Icons.keyboard_arrow_down),   
                  items: TYPES.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Icon(getIcon(type)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      type = newValue!;
                    });
                  },
                ),
                TextField(
                  controller: _nameController,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void initTextVals() {
    _nameController.text = widget.exercise.name;
    _nameController.text = widget.exercise.name;
    _nameController.text = widget.exercise.name;
    _nameController.text = widget.exercise.name;
    _nameController.text = widget.exercise.name;
  }

  void initCurrVals() {
    _sets = widget.exercise.sets;
    _nameController.text = widget.exercise.name;
    type = widget.exercise.type;

    for (int i = 0; i < _sets; i++) {
      repsControllers.add(
          TextEditingController(text: widget.exercise.reps?[i].toString()));
      wtsControllers.add(
          TextEditingController(text: widget.exercise.weights?[i].toString()));
      durationsControllers.add(TextEditingController(
          text: widget.exercise.durations?[i].toString()));
    }
    //TODO: implement notes
    initTextVals();
  }
}
