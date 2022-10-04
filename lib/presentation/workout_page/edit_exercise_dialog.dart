import 'package:flutter/material.dart';
import 'package:gym_app/constants/exercise_options.dart';
import 'package:gym_app/constants/styles.dart';
import 'package:gym_app/logic/models/workout.dart';
import 'package:gym_app/presentation/workout_page/edit_exercise_dialog_body.dart';

class EditExerciseDialog extends StatefulWidget {
  final Exercise exercise;
  final int index;
  final Function(int, Exercise) modifyExercise;
  final Function(int) deleteExercise;

  const EditExerciseDialog(
      {super.key,
      required this.exercise,
      required this.index,
      required this.modifyExercise,
      required this.deleteExercise});

  @override
  State<EditExerciseDialog> createState() => _EditExerciseDialogState();
}

class _EditExerciseDialogState extends State<EditExerciseDialog> {
  late TextEditingController _nameController;
  late int _sets;
  late String _type;
  List<TextEditingController> _durationsControllers = [];
  List<TextEditingController> _repsControllers = [];
  List<TextEditingController> _wtsControllers = [];
  late bool _specifyDurations;

  @override
  void initState() {
    initCurrVals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: TextField(
            controller: _nameController,
            style: editExerciseDialogNameStyle,
            decoration: exerciseNameIpDecor),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.7,
        child: ListView(
          children: [
            selectExerciseTypeRow(
              type: _type,
              onChanged: (String? newValue) => setState(() {
                _type = newValue!;
              }),
            ),
            selectNumberOfSetsRow(
              sets: _sets,
              onChanged: (int? newValue) => setState(() {
                modifyNumberOfSets(newValue!);
              }),
            ),
            modifyRepsRow(sets: _sets, repsControllers: _repsControllers),
            selectWtsVsDurationsSwitch(
              specifyDurations: _specifyDurations,
              onChanged: (newVal) => setState(() {
                _specifyDurations = !_specifyDurations;
              }),
            ),
            selectWtsDurationsRow(
                specifyDurations: _specifyDurations,
                sets: _sets,
                wtsControllers: _wtsControllers,
                durationsControllers: _durationsControllers),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: dialogActionButtons(
        onDelete: () => confirmDelete(
                context: context, deleteExercise: widget.deleteExercise)
            .then((performDelete) {
          if (performDelete == true) Navigator.of(context).pop();
        }),
        onCancel: () => confirmCancel(context: context).then((cancelUpdate) {
          if (cancelUpdate == true) Navigator.of(context).pop();
        }),
        onSave: () {
          Navigator.of(context).pop();
          saveExerciseChanges();
        },
      ),
    );
  }

  Future<bool?> confirmDelete(
      {required BuildContext context, required Function(int) deleteExercise}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return confirmDeleteDialog(
          onCancel: () => Navigator.pop(context, false),
          onDeleteConfirm: () {
            Navigator.pop(context, true);
            deleteExercise(widget.index); //TODO: implement
          },
        );
      },
    );
  }

  Future<bool?> confirmCancel({required BuildContext context}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return confirmCancelDialog(
          onBack: () => Navigator.pop(context, false),
          onCancelConfirm: () => Navigator.pop(context, true),
        );
      },
    );
  }

  void saveExerciseChanges() {
    widget.modifyExercise(
        widget.index,
        Exercise(
          name: _nameController.text,
          type: _type,
          sets: _sets,
          reps: allInputsEmpty(_repsControllers)
              ? null
              : _repsControllers
                  .map((e) => e.text != ""
                      ? double.parse(e.text).floor().toString()
                      : DEFAULT_REPS.toString())
                  .toList(),
          weights: allInputsEmpty(_wtsControllers)
              ? null
              : _wtsControllers
                  .map((e) => e.text != ""
                      ? double.parse(e.text).floor().toString()
                      : DEFAULT_WT.toString())
                  .toList(),
          durations: allInputsEmpty(_durationsControllers)
              ? null
              : _durationsControllers.map((e) => e.text != ""
                      ? e.text
                      : DEFAULT_DURATION.toString()).toList(),
        ));
    // TODO: something... idk what but something.
    //Something seems missing... i think...
  }

  void initCurrVals() {
    _nameController = TextEditingController(text: widget.exercise.name);
    _sets = widget.exercise.sets;
    _nameController.text = widget.exercise.name;
    _type = widget.exercise.type;

    if (widget.exercise.durations != null) {
      _specifyDurations = true;
    } else {
      _specifyDurations = false;
    }

    for (int i = 0; i < _sets; i++) {
      _repsControllers.add(TextEditingController(
          text: widget.exercise.reps != null && widget.exercise.reps!.length > i
              ? widget.exercise.reps![i].toString()
              : ""));
      _wtsControllers.add(TextEditingController(
          text: widget.exercise.weights != null &&
                  widget.exercise.weights!.length > i
              ? widget.exercise.weights![i].toString()
              : ""));
      _durationsControllers.add(TextEditingController(
          text: widget.exercise.durations != null &&
                  widget.exercise.durations!.length > i
              ? widget.exercise.durations![i].toString()
              : ""));
    }
    //TODO: implement notes
  }

  void modifyNumberOfSets(int newSetsVal) {
    if (_sets == newSetsVal) return;

    if (_sets > newSetsVal) {
      _repsControllers = _repsControllers.sublist(0, newSetsVal);
      _wtsControllers = _repsControllers.sublist(0, newSetsVal);
      _durationsControllers = _repsControllers.sublist(0, newSetsVal);
    } else {
      for (int i = 0; i < newSetsVal - _sets; i++) {
        _repsControllers.add(TextEditingController());
        _durationsControllers.add(TextEditingController());
        _wtsControllers.add(TextEditingController());
      }
    }
    _sets = newSetsVal;
  }

  bool allInputsEmpty(List<TextEditingController> controllers) {
    if (controllers.isEmpty) return true;

    for (int i = 0; i < controllers.length; i++) {
      if (controllers[i].text != "") return false;
    }
    return true;
  }
}
