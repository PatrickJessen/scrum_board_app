import 'package:flutter/material.dart';
import 'package:scrum_board_app/Screens/DropDownMenu.dart';
import 'package:scrum_board_app/src/Managers/TaskManager.dart';
import 'package:scrum_board_app/src/api/FirebaseAccess.dart';

import '../src/Task.dart';
import '../src/User.dart';
import 'BoardScreen.dart';
import 'EditText.dart';

class TaskScreenWidget extends StatefulWidget {
  const TaskScreenWidget({Key key}) : super(key: key);

  @override
  State<TaskScreenWidget> createState() => TaskScreen();
}

class TaskScreen extends State<TaskScreenWidget> {
  Task task;
  TaskManager tm = TaskManager();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 5),
                          alignment: Alignment.topLeft,
                          child: ReturnButton()),
                      Container(
                          padding: const EdgeInsets.only(left: 100),
                          alignment: Alignment.topLeft,
                          child: DeleteButton()),
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 50),
                      child: Stack(children: [
                        Container(
                          padding: const EdgeInsets.only(top: 30),
                          alignment: Alignment.topLeft,
                          child: EditText(
                            type: StringType.TITLE,
                            task: task,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 100),
                          alignment: Alignment.topLeft,
                          child: EditText(
                              type: StringType.DESCRIPTION, task: task),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 170),
                          alignment: Alignment.topLeft,
                          child:
                              EditText(type: StringType.ASSIGNEDTO, task: task),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 220),
                          alignment: Alignment.topLeft,
                          child:
                              DropDownMenu(task: task, type: MenuType.POINTS),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 220, left: 70),
                          alignment: Alignment.topLeft,
                          child:
                              DropDownMenu(task: task, type: MenuType.PRIORITY),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 220, left: 210),
                          alignment: Alignment.topLeft,
                          child: DropDownMenu(task: task, type: MenuType.STATE),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text("Title")),
                        const Padding(
                            padding: EdgeInsets.only(top: 70),
                            child: Text("Description")),
                        const Padding(
                            padding: EdgeInsets.only(top: 140),
                            child: Text("Assign to")),
                        const Padding(
                            padding: EdgeInsets.only(top: 210),
                            child: Text("Points")),
                        const Padding(
                            padding: EdgeInsets.only(top: 210, left: 90),
                            child: Text("Priority")),
                        const Padding(
                            padding: EdgeInsets.only(top: 210, left: 240),
                            child: Text("State")),
                      ])),
                ],
              ))
        ],
      ),
    );
  }

  Widget ReturnButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BoardWidget()));
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
      ),
      child: const Text('Return'),
    );
  }

  Widget DeleteButton() {
    return ElevatedButton(
      onPressed: () {
        tm.DeleteTask(task.id);
        String user = User.currentUser.username;
        String msg = "$user Deleted a task: ${task.title}";
        FirebaseAccess.SendPushNotification(msg, "Deleted task");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BoardWidget()));
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
      ),
      child: const Text('Delete'),
    );
  }
}
