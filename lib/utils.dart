import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// we can't store class Color to localstorage so convert to string
convertStringColor(color) {
  String stringColor = color;
  String valueString = stringColor.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  Color otherColor = new Color(value);
  return otherColor;
}

// set todo list to shared Preference
setDataToSharedPreference(List<dynamic> todos) async {
  final prefs = await SharedPreferences.getInstance();

  // convert todolist List<Object> to string to save in saved preference
  List<String> todoList =
      todos.map((item) => json.encode(item.toMap())).toList();

  prefs
      .setStringList("todo_list", todoList)
      .then((value) => print('saved in todo_list'))
      .catchError((err) => print('error in save' + err));
}
