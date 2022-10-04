import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TextStyle appBarTextStyle = TextStyle();

const TextStyle editExerciseDialogHeadingStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
const TextStyle editExerciseDialogNameStyle =
    TextStyle(fontSize: 23, fontWeight: FontWeight.w600);

const TextStyle exerciseTypeNameStyle = TextStyle(fontSize: 17);



const InputDecoration exerciseNameIpDecor = InputDecoration.collapsed(
  hintText: "Exercise name",
  border: UnderlineInputBorder(),
);
const InputDecoration repsIpDecor = InputDecoration(
  hintText: "Reps",
  border: UnderlineInputBorder(),
);
const InputDecoration wtsIpDecor = InputDecoration(
  hintText: "Wt",
  border: UnderlineInputBorder(),
);
const InputDecoration durationsIpDecor = InputDecoration(
  hintText: "mm:ss",
  border: UnderlineInputBorder(),
);
