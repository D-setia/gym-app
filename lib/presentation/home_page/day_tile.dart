import 'package:flutter/material.dart';
import 'package:gym_app/logic/models/day.dart';
import 'package:gym_app/presentation/workout_page/workout_details_page.dart';

class DayTile extends StatelessWidget {
  final Day day;
  final bool isEditModeActive;

  const DayTile({required this.day, required this.isEditModeActive, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onDayTileTap(context),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 6, 2),
                  child: Text(
                    "Day ${day.dayNo}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 2, 6, 6),
                  child: Text(
                    day.workoutType,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDayTileTap(BuildContext context) {
    if (isEditModeActive) {
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => WorkoutDetailsPage(
                workoutTitle: day.workoutType,
                dayNo: day.dayNo,
              )));
    }
  }
}
