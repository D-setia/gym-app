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
  bool isEditModeActive = false;
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
            onEditButtonClick: onEditButtonClick,
            isEditModeActive: isEditModeActive),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: daysWidgets,
          ),
        ),
        floatingActionButton: isEditModeActive
            ? FloatingActionButton(onPressed: onNewDayAdded)
            : Container());
  }

  void onNewDayAdded() {}

  void onEditButtonClick() => setState(() {
        isEditModeActive = !isEditModeActive;
      });

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
        isEditModeActive: isEditModeActive,
      ));
    }
    setState(() {
      daysWidgets = tempDaysWidgets;
    });
  }

  @override
  void dispose() {
    //TODO: saveDaysData();
    super.dispose();
  }
}
