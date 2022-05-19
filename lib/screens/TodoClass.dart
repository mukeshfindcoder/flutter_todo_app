import 'package:flutter/material.dart';

class Todo {
  Todo(
      {required this.name,
      required this.checked,
      required this.subTitle,
      required this.selectedColor,
      required this.id});
  final String name;
  bool checked;
  final String subTitle;
  String selectedColor;
  int id;

  // method to convert todo to serializing json
  factory Todo.fromJson(Map<String, dynamic> map) => Todo(
        name: map["name"],
        checked: map["checked"],
        subTitle: map["subTitle"],
        selectedColor: map["selectedColor"],
        id: map["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "checked": checked,
        "subTitle": subTitle,
        "selectedColor": selectedColor,
        "id": id
      };
}
