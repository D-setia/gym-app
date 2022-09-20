import 'package:flutter/material.dart';
import 'package:gym_app/constants/styles.dart';

AppBar myAppBar(
    {required String title,
    required VoidCallback onEditButtonClick,
    bool autoImplyLeading = true,
    Key? key}) {
  return AppBar(
    key: key,
    title: Text(
      title,
      style: appBarTextStyle,
    ),
    automaticallyImplyLeading: autoImplyLeading,
    actions: [
      IconButton(onPressed: onEditButtonClick, icon: const Icon(Icons.edit))
    ],
  );
}
