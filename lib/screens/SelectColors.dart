import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/utils.dart';

class SelectColors extends StatefulWidget {
  const SelectColors(
      {Key? key,
      required this.selectedColor,
      required this.handleColorChange,
      required this.colorOptions})
      : super(key: key);
  final String selectedColor;
  final Function handleColorChange;
  final List<Color> colorOptions;
  @override
  State<SelectColors> createState() => _SelectColorsState();
}

class _SelectColorsState extends State<SelectColors> {
  String selectedColor = "";

  @override
  void initState() {
    super.initState();
    selectedColor = widget.selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colorOptions = widget.colorOptions;
    return SizedBox(
        height: 100,
        width: 300.0,
        child: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 20, bottom: 5),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Select Priority",
                  textAlign: TextAlign.left,
                )),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.only(right: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () =>
                              widget.handleColorChange(colorOptions[index]),
                          child: colorOptions[index] !=
                                  convertStringColor(widget.selectedColor)
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  child: CircleAvatar(
                                      backgroundColor: colorOptions[index],
                                      radius: 8))
                              : Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: colorOptions[index]
                                        .withOpacity(0.40), // border color
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(3), // border width
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: convertStringColor(widget
                                            .selectedColor), // inner circle color
                                      ),
                                      child: Container(), // inner content
                                    ),
                                  ),
                                ),
                        )))
            // )
          ],
        ));
  }
}
