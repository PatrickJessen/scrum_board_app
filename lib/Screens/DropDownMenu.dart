import 'package:flutter/material.dart';
import 'package:scrum_board_app/src/StateUtils.dart';

import '../src/Managers/TaskManager.dart';
import '../src/Task.dart';

enum MenuType { STATE, PRIORITY, POINTS }

class DropDownMenu extends StatefulWidget {
  final Task task;
  final MenuType type;
  const DropDownMenu({Key key, this.task, this.type}) : super(key: key);

  @override
  State<DropDownMenu> createState() => DropDownMenuState(task, type);
}

class DropDownMenuState extends State<DropDownMenu> {
  Task task;
  MenuType type;

  List<String> states = ["TODO", "IN PROGRESS", "REVIEW", "DONE"];
  List<String> priorities = ["VERY LOW", "LOW", "MEDIUM", "HIGH", "VERY HIGH"];
  List<int> fibonacci = [0, 1, 1, 2, 3, 5, 8, 13, 21];
  TaskManager manager;

  @override
  void initState() {
    super.initState();
    manager = TaskManager();
  }

  DropDownMenuState(this.task, this.type);
  @override
  Widget build(BuildContext context) {
    switch (type) {
      case MenuType.STATE:
        {
          return Positioned(
              child: DropdownButton(
            // Initial Value
            value: StateUtils.ConvertTaskStateToString(task.state),

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: states.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String newValue) {
              setState(() {
                String statesVal = newValue;
                task.state = StateUtils.ConvertStringToTaskState(statesVal);
              });
              manager.UpdateTask(task);
            },
          ));
        }
      case MenuType.PRIORITY:
        {
          return Positioned(
              child: DropdownButton(
            // Initial Value
            value: StateUtils.ConvertTaskPriorityToString(task.priority),

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: priorities.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String newValue) {
              setState(() {
                String statesVal = newValue;
                task.priority =
                    StateUtils.ConvertStringToTaskPriority(statesVal);
              });
              manager.UpdateTask(task);
            },
          ));
        }
      case MenuType.POINTS:
        {
          return Positioned(
              child: DropdownButton(
            // Initial Value
            value: task.points,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: fibonacci.map((int items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items.toString()),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (int newValue) {
              setState(() {
                int statesVal = newValue;
                task.points = statesVal;
              });
              manager.UpdateTask(task);
            },
          ));
        }
    }
  }
}
