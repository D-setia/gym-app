import 'dart:convert';

Day dayFromJson(String str) => Day.fromJson(json.decode(str));
String dayToJson(Day data) => json.encode(data.toJson());

List<Day> daysFromJson(String str) => List<Day>.from(json.decode(str).map((x) => Day.fromJson(x)));
String daysToJson(List<Day> days) => json.encode(List<dynamic>.from(days.map((day) => day.toJson())));

class Day {
    Day({
        required this.workoutType,
        required this.dayNo,
    });

    String workoutType;
    int dayNo;

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        workoutType: json["workoutType"],
        dayNo: json["dayNo"],
    );

    Map<String, dynamic> toJson() => {
        "workoutType": workoutType,
        "dayNo": dayNo,
    };
}

/*
[{
  "workoutType": "Chest and biceps",
  "dayNo": 1,
}
]
*/
