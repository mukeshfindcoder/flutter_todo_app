import 'package:flutter/material.dart';
import 'package:todo_app/screens/TodoClass.dart';
import 'package:todo_app/utils.dart';

class TodoItem extends StatelessWidget {
  TodoItem(
      {required this.todo,
      required this.onTodoChanged,
      required this.selectedColor,
      required this.handleDeleteItem})
      : super(key: ObjectKey(todo));

  final Todo todo;
  String selectedColor;
  final Function onTodoChanged;
  final Function handleDeleteItem;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 5),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Column(children: <Widget>[
            ListTile(
              minLeadingWidth: 10,
              onTap: () {
                onTodoChanged(todo);
              },
              leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                        radius: 5,
                        backgroundColor: convertStringColor(selectedColor))
                  ]),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        handleDeleteItem(todo.id);
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: Color.fromARGB(255, 214, 87, 87),
                        radius: 15,
                        child: Icon(Icons.delete_forever_outlined),
                      ))
                ],
              ),
              title: Text(
                todo.name,
                style: _getTextStyle(todo.checked),
              ),
              subtitle: Text(todo.subTitle),
            )
          ]),
        ),
      ),
    ]);
  }
}
