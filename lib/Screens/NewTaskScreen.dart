// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scrum_board_app/Screens/BoardScreen.dart';
import 'package:scrum_board_app/src/Managers/TaskManager.dart';
import 'package:scrum_board_app/src/api/ApiAccess.dart';
import '../src/StateUtils.dart';
import '../src/Task.dart';

class NewTaskWidget extends StatefulWidget {
  const NewTaskWidget({Key key}) : super(key: key);

  @override
  State<NewTaskWidget> createState() => NewTaskScreen();
}

class NewTaskScreen extends State<NewTaskWidget> {
  Task task;
  TaskManager manager = TaskManager();
  String statesVal = "TODO";
  List<String> states = ["TODO", "IN PROGRESS", "REVIEW", "DONE"];
  String priorityVal = "VERY LOW";
  List<String> priorities = ["VERY LOW", "LOW", "MEDIUM", "HIGH", "VERY HIGH"];
  int fibonacciVal = 0;
  List<int> fibonacci = [0, 1, 1, 2, 3, 5, 8, 13, 21];
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController assignedTo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Stack(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Stack(children: [
                          Container(
                            alignment: Alignment.center,
                            child: SaveButton(),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: ReturnButton(),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: TextField(
                                    controller: title,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Title",
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: TextField(
                                    controller: description,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Description",
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: TextField(
                                    controller: assignedTo,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Assign To",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Positioned(left: 200, child: Text("State")),
                                DropDownMenuStates(),
                                SizedBox(height: 5),
                                Positioned(left: 200, child: Text("Priority")),
                                DropDownMenuPriority(),
                                SizedBox(height: 5),
                                Positioned(left: 200, child: Text("Points")),
                                //CustomText("Points", 100, 50),
                                DropDownMenuFibonacci(),
                              ],
                            ),
                          )
                        ])),
                  ],
                )
              ],
            )));
  }

  void AddTask() {
    Task task = Task(
        title.text,
        description.text,
        fibonacciVal,
        assignedTo.text,
        StateUtils.ConvertStringToTaskState(statesVal),
        StateUtils.ConvertStringToTaskPriority(priorityVal));
    manager.AddTask(task);
  }

  Widget ReturnButton() {
    return Positioned(
      top: 20,
      left: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BoardWidget()));
        },
        child: Text('Return'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
      ),
    );
  }

  Widget SaveButton() {
    return Positioned(
      top: 20,
      left: 60,
      child: ElevatedButton(
        onPressed: () {
          AddTask();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BoardWidget()));
        },
        child: Text('Save Task'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
      ),
    );
  }

  Widget CustomText(String str, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: Text(str),
    );
  }

  Widget CustomTextField(
      String str, bool isSecure, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        obscureText: isSecure,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: str,
        ),
      ),
    );
  }

  Widget DropDownMenuStates() {
    return Positioned(
        child: DropdownButton(
      // Initial Value
      value: statesVal,

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
          statesVal = newValue;
        });
      },
    ));
  }

  Widget DropDownMenuPriority() {
    return SizedBox(
        child: DropdownButton(
      // Initial Value
      value: priorityVal,

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
          priorityVal = newValue;
        });
      },
    ));
  }

  Widget DropDownMenuFibonacci() {
    return SizedBox(
        child: DropdownButton(
      // Initial Value
      value: fibonacciVal,

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
          fibonacciVal = newValue;
        });
      },
    ));
  }
}
