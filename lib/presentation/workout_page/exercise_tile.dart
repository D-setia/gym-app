import 'package:flutter/material.dart';
import 'package:gym_app/constants/strings.dart';
import 'package:gym_app/logic/models/workout.dart';

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
          onDoubleTap: editExercise,
          child: ListTile(
            leading: Icon(
              getIcon(),
              size: 40,
            ),
            title: Text(
              exercise.name,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getSubtitle()),
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

  void editExercise() {
    //TODO: implement
  }

  List<Widget> getSubtitle() {
    List<Widget> subtitle = [];
    if (exercise.sets == 0) return subtitle;
    if (exercise.reps != null) {
      String top = "Reps: ";
      String bottom = "";

      if (exercise.times != null) {
        bottom = "Duration: ";
        top += "    ";

        for (int i = 0; i < exercise.sets; i++) {
          
        }
      } else if (exercise.weights != null) {
        bottom = "Weights: ";
        top += "   ";

        for (int i = 0; i < exercise.sets; i++) {
          if (i != 0) top += ", ";
          top += exercise.reps![i].toString();
        }
      } else {
        for (int i = 0; i < exercise.sets; i++) {
          if (i != 0) top += ", ";
          top += exercise.reps![i].toString();
        }
      }
    }

    return subtitle;
  }
}
