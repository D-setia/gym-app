import 'package:flutter/material.dart';
import 'package:gym_app/constants/styles.dart';

AppBar myAppBar(
    {required String title,
    required VoidCallback onEditButtonClick,
    required bool isEditModeActive,
    bool autoImplyLeading = false,
    Key? key}) {
  return AppBar(
    key: key,
    title: Text(
      title,
      style: appBarTextStyle,
    ),
    automaticallyImplyLeading: autoImplyLeading,
    actions: [
      IconButton(
          onPressed: onEditButtonClick,
          icon: Icon(isEditModeActive ? Icons.check : Icons.edit)),
    ],
  );
}
