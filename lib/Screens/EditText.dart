import 'package:flutter/material.dart';
import 'package:scrum_board_app/src/Managers/TaskManager.dart';

import '../src/Task.dart';

enum StringType { TITLE, DESCRIPTION, ASSIGNEDTO }

class EditText extends StatefulWidget {
  final StringType type;
  final Task task;
  const EditText({Key key, this.type, this.task}) : super(key: key);

  @override
  State<EditText> createState() => _EditTextState(type, this.task);
}

class _EditTextState extends State<EditText> {
  Task task;
  StringType type;
  bool isEditing = false;
  TextEditingController controller;

  _EditTextState(this.type, this.task);

  TaskManager manager;
  @override
  void initState() {
    super.initState();
    setState(() {
      switch (type) {
        case StringType.TITLE:
          controller = TextEditingController(text: task.title);
          break;
        case StringType.DESCRIPTION:
          controller = TextEditingController(text: task.description);
          break;
        case StringType.ASSIGNEDTO:
          controller = TextEditingController(text: task.assignedTo);
          break;
      }
      manager = TaskManager();
    });
  }

  @override
  Widget build(BuildContext context) {
    return EditTextField();
  }

  Widget EditTextField() {
    if (isEditing) {
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              String val = newValue;
              if (!val.isEmpty) {
                switch (type) {
                  case StringType.TITLE:
                    task.title = val;
                    break;
                  case StringType.DESCRIPTION:
                    task.description = val;
                    break;
                  case StringType.ASSIGNEDTO:
                    task.assignedTo = val;
                    break;
                }
              }
              isEditing = false;
            });
            manager.UpdateTask(task);
          },
          autofocus: true,
          controller: controller,
        ),
      );
    }
    return InkWell(
        onTap: () {
          setState(() {
            isEditing = true;
          });
        },
        child: Text(
          controller.text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
}
