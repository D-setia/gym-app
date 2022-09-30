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
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.width*0.7,
      child: ListView(
        children: [
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width*0.8,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                 DropdownButton(
                  elevation: 0,
                  value: type,
                  icon: const Icon(Icons.keyboard_arrow_down),   
                  items: TYPES.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(getIcon(item), size: 40,),
                            Text(item)
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      type = newValue!;
                    });
                  },
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _nameController,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration.collapsed(hintText: "Exercise name", border: UnderlineInputBorder(), ),
                  ),
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
