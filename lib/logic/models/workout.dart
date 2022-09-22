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
    this.duration,
    this.notes,
    this.reps,
    this.weights,
    this.times,
  });

  String name;
  String type;
  int sets;
  String? duration;
  List<String>? notes;
  List<int>? reps;
  List<int>? weights;
  List<String>? times;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        name: json["name"],
        type: json["type"],
        duration: json["duration"],
        sets: json["sets"],
        notes: List<String>.from(json["notes"].map((x) => x)),
        reps: List<int>.from(json["reps"].map((x) => x)),
        weights: List<int>.from(json["weights"].map((x) => x)),
        times: List<String>.from(json["times"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "duration": duration,
        "type": type,
        "sets": sets,
        "notes":
            (notes == null) ? [] : List<dynamic>.from(notes!.map((x) => x)),
        "reps": (reps == null) ? [] : List<dynamic>.from(reps!.map((x) => x)),
        "weights":
            (weights == null) ? [] : List<dynamic>.from(weights!.map((x) => x)),
        "times":
            (times == null) ? [] : List<dynamic>.from(times!.map((x) => x)),
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
