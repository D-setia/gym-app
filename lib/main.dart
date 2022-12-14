import 'package:flutter/material.dart';
import 'package:gym_app/constants/theme.dart';
import 'package:gym_app/presentation/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: myDarkTheme,
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}
