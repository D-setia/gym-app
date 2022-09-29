  import 'package:flutter/material.dart';
import 'package:gym_app/constants/strings.dart';

IconData? getIcon(String exerciseType) {
    switch (exerciseType) {
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
  