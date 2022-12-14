// To parse this JSON data, do
//
//     final exercise = exerciseFromJson(jsonString);

import 'dart:convert';

List<Workout> workoutListFromJson(String str) =>
    List<Workout>.from(json.decode(str).map((x) => Workout.fromJson(x)));
String workoutListToJson(List<Workout> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Workout workoutFromJson(String str) => Workout.fromJson(json.decode(str));
String workoutToJson(Workout data) => json.encode(data.toJson());

class Workout {
  Workout({
    required this.exercises,
  });

  List<Exercise> exercises;

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        exercises: List<Exercise>.from(
            json["exercises"].map((x) => Exercise.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
      };
}

class Exercise {
  Exercise({
    required this.name,
    this.sets = 3,
    required this.type,
    this.notes,
    this.reps,
    this.weights,
    this.durations,
  });

  String name;
  String type;
  int sets;
  List<String>? notes;
  List<String>? reps;
  List<String>? weights;
  List<String>? durations;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        name: json["name"],
        type: json["type"],
        sets: json["sets"],
        notes: List<String>.from(json["notes"].map((x) => x)),
        reps: List<String>.from(json["reps"].map((x) => x)),
        weights: List<String>.from(json["weights"].map((x) => x)),
        durations: List<String>.from(json["durations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "sets": sets,
        "notes":
            (notes == null) ? [] : List<dynamic>.from(notes!.map((x) => x)),
        "reps": (reps == null) ? [] : List<dynamic>.from(reps!.map((x) => x)),
        "weights":
            (weights == null) ? [] : List<dynamic>.from(weights!.map((x) => x)),
        "durations":
            (durations == null) ? [] : List<dynamic>.from(durations!.map((x) => x)),
      };
}

// [{ "exercises" : [{
//   "name": "Chest and biceps",
//   "sets": 1,
//   "notes" : ["note1", "note2"],
//   "reps" : [1,2,3],
//   "weights" : [1,2,3],
//   "times" : ["50", "60"]
// }]}]
