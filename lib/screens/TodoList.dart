import 'package:flutter/material.dart';
import 'package:todo_app/screens/SelectColors.dart';
import 'package:todo_app/screens/TodoClass.dart';
import 'package:todo_app/screens/TodoItem.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:todo_app/utils.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  var _formKey = GlobalKey<FormState>();
  // control title field state
  final TextEditingController _textFieldControllerTitle =
      TextEditingController();
  // control subtitle field state
  final TextEditingController _textFieldControllerSubTitle =
      TextEditingController();
  // todo list state
  final List<Todo> _todos = <Todo>[];
  // color list for selection
  final List<Color> colorOptions = [
    const Color(0xC33148B9),
    const Color(0xC37CB931),
    const Color(0xC5C07224),
    const Color(0xB4BC3627)
  ];
  // state of selected color
  String _selectedColor = "";
  @override
  initState() {
    super.initState();
    getSharedPrefs();
    _selectedColor = '${colorOptions[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: _todos.map((Todo todo) {
            return TodoItem(
              todo: todo,
              onTodoChanged: handleTodoChange,
              selectedColor: todo.selectedColor,
              handleDeleteItem: handleDeleteItem,
            );
          }).toList()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }

  // in load of app get list from shared preference and store in state
  Future getSharedPrefs() async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    List<String> values = prefss.getStringList("todo_list") ?? [];
    // from json for serializable
    final List<Todo> getTodoList =
        values.map((item) => Todo.fromJson(json.decode(item))).toList();
    setState(() {
      _todos.addAll(getTodoList);
    });
  }

// change state of todo
  void handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

//  add todo item
  Future<void> _addTodoItem(String name, String subTitle) async {
    // check validation empty fields
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid == false) {
      return;
    } else {
      _formKey.currentState?.save();
      setState(() {
        _todos.add(Todo(
            name: name,
            checked: false,
            subTitle: subTitle,
            selectedColor: _selectedColor,
            id: DateTime.now().millisecondsSinceEpoch));
        _selectedColor = '${colorOptions[0]}';
      });

      setDataToSharedPreference(_todos);
      _textFieldControllerTitle.clear();
      _textFieldControllerSubTitle.clear();
      _selectedColor = '${colorOptions[0]}';
      Navigator.of(context).pop();
    }
  }

  void handleDeleteItem(int id) async {
    setState(() {
      _todos.removeWhere((item) => item.id == id);
    });
    setDataToSharedPreference(_todos);
    // print(x);
  }

  errortext(value) {
    if (value != null && value.isEmpty) {
      print(value);
      return "Field can't be empty";
    }
    return null;
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add a new todo item'),
            content: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _textFieldControllerTitle,
                      decoration: const InputDecoration(
                          hintText: 'Type your todo title'),
                      validator: (value) =>
                          value!.isEmpty ? "Title Can't be emplty" : null,
                    ),
                    TextFormField(
                      controller: _textFieldControllerSubTitle,
                      decoration: const InputDecoration(
                          hintText: 'Type your todo subtitle'),
                      validator: (value) =>
                          value!.isEmpty ? "Subtitle can't be Empty" : null,
                    ),
                    SelectColors(
                        selectedColor: _selectedColor,
                        handleColorChange: (color) {
                          setState(() {
                            _selectedColor = color.toString();
                          });
                        },
                        colorOptions: colorOptions),
                  ],
                )),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  _addTodoItem(_textFieldControllerTitle.text,
                      _textFieldControllerSubTitle.text);
                },
              ),
            ],
          );
        });
      },
    );
  }
}
