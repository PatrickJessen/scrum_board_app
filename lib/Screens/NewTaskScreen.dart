// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:scrum_board_app/Screens/BoardScreen.dart';
import 'package:scrum_board_app/src/Managers/TaskManager.dart';
import 'package:scrum_board_app/src/api/ApiAccess.dart';
import '../src/StateUtils.dart';
import '../src/Task.dart';
import '../src/User.dart';
import '../src/api/FirebaseAccess.dart';

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
  String sprint;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    sprint = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 50),
              child: Stack(
                children: [
                  Container(
                      child: Stack(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 5),
                          alignment: Alignment.topLeft,
                          child: SaveButton()),
                      Container(
                          padding: EdgeInsets.only(left: 130),
                          alignment: Alignment.topLeft,
                          child: ReturnButton()),
                    ],
                  )),
                  Container(
                      padding: EdgeInsets.only(top: 50),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: title,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text.rich(
                                  TextSpan(children: <InlineSpan>[
                                    WidgetSpan(child: Text("Title")),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 80),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: description,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text.rich(
                                  TextSpan(children: <InlineSpan>[
                                    WidgetSpan(child: Text("Description")),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 155),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: assignedTo,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text.rich(
                                  TextSpan(children: <InlineSpan>[
                                    WidgetSpan(child: Text("Assign To")),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 215),
                              child: Text("State")),
                          Container(
                            padding: EdgeInsets.only(top: 230),
                            alignment: Alignment.topLeft,
                            child: DropDownMenuStates(),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 215, left: 140),
                              child: Text("Priority")),
                          Container(
                            padding: EdgeInsets.only(top: 230, left: 140),
                            alignment: Alignment.topLeft,
                            child: DropDownMenuPriority(),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 215, left: 290),
                              child: Text("Points")),
                          Container(
                            padding: EdgeInsets.only(top: 230, left: 290),
                            alignment: Alignment.topLeft,
                            child: DropDownMenuFibonacci(),
                          ),
                        ],
                      )),
                ],
              )),
        ],
      ),
    );
  }

  void AddTask() {
    Task task = Task(
        title.text,
        description.text,
        fibonacciVal,
        assignedTo.text,
        StateUtils.ConvertStringToTaskState(statesVal),
        StateUtils.ConvertStringToTaskPriority(priorityVal));
    task.boardTitle = sprint;
    manager.AddTask(task);
  }

  Widget ReturnButton() {
    return ElevatedButton(
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
    );
  }

  Widget SaveButton() {
    return ElevatedButton(
      onPressed: () async {
        String user = User.currentUser.username;
        String msg = "$user Created a new task: ${title.text}";
        await FirebaseAccess.SendPushNotification(msg, "new task created");
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
    return DropdownButton(
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
    );
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
