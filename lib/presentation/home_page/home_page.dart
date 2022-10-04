import 'package:flutter/material.dart';
import 'package:gym_app/constants/strings.dart';
import 'package:gym_app/data/days.dart';
import 'package:gym_app/logic/models/day.dart';
import 'package:gym_app/presentation/home_page/day_tile.dart';
import 'package:gym_app/presentation/my_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> daysWidgets;
  late List<Day> days;

  @override
  void initState() {
    daysWidgets = List<Widget>.empty(growable: true);
    days = [];
    loadDaysData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(
            title: "Workout Tracker",
            showEditButton: false),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: daysWidgets,
          ),
        ),);
  }

  void loadDaysData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? daysListJson = prefs.getString(DAYS);
    if (daysListJson == null) {
      days = defaultDays;
    } else {
      days = daysFromJson(daysListJson);
    }
    daysWidgets.clear();
    List<Widget> tempDaysWidgets = [];
    for (Day day in days) {
      tempDaysWidgets.add(DayTile(
        day: day,
        isEditModeActive: false,
      ));
    }
    setState(() {
      daysWidgets = tempDaysWidgets;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
