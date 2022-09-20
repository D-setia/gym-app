import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/logic/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:gym_app/presentation/my_app_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "Workout Tracker", onEditButtonClick: () {}),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return state.isEditModeActive
              ? FloatingActionButton(onPressed: onNewDayAdded)
              : Container();
        },
      ),
    );
  }

  void onNewDayAdded() {
  }
}
