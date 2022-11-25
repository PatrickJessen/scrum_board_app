import 'package:flutter/material.dart';
import 'package:scrum_board_app/Screens/DropDownMenu.dart';

import '../src/Task.dart';
import 'BoardScreen.dart';
import 'EditText.dart';

class TaskScreenWidget extends StatefulWidget {
  const TaskScreenWidget({Key key}) : super(key: key);

  @override
  State<TaskScreenWidget> createState() => TaskScreen();
}

class TaskScreen extends State<TaskScreenWidget> {
  Task task;

  @override
  void initState() {
    super.initState();
    //_editingController = TextEditingController(text: task.title);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: ReturnButton(),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 260,
              child: Text("Title"),
            ),
            Positioned(
                left: 160,
                top: 20,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: 240.0,
                      height: 42.0,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.0, color: Colors.lightBlue.shade600),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: EditText(
                          type: StringType.TITLE,
                          task: task,
                        ),
                      ),
                    ),
                  ],
                )),
            Positioned(
              left: 540,
              child: Text("Description"),
            ),
            Positioned(
                left: 460,
                top: 20,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: 240.0,
                      height: 42.0,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.0, color: Colors.lightBlue.shade600),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: EditText(
                              type: StringType.DESCRIPTION, task: task)),
                    ),
                  ],
                )),
            Positioned(
              left: 840,
              child: Text("Assigned To"),
            ),
            Positioned(
                left: 760,
                top: 20,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: 240.0,
                      height: 42.0,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.0, color: Colors.lightBlue.shade600),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: EditText(
                              type: StringType.ASSIGNEDTO, task: task)),
                    ),
                  ],
                )),
            Positioned(
              left: 260,
              top: 100,
              child: Text("State"),
            ),
            Positioned(
                left: 160,
                top: 120,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: 240.0,
                      height: 42.0,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.0, color: Colors.lightBlue.shade600),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                          child:
                              DropDownMenu(task: task, type: MenuType.STATE)),
                    ),
                  ],
                )),
            Positioned(
              left: 540,
              top: 100,
              child: Text("Priority"),
            ),
            Positioned(
                left: 460,
                top: 120,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: 240.0,
                      height: 42.0,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.0, color: Colors.lightBlue.shade600),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: DropDownMenu(
                              task: task, type: MenuType.PRIORITY)),
                    ),
                  ],
                )),
            Positioned(
              left: 840,
              top: 100,
              child: Text("Points"),
            ),
            Positioned(
                left: 760,
                top: 120,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: 240.0,
                      height: 42.0,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.0, color: Colors.lightBlue.shade600),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                          child:
                              DropDownMenu(task: task, type: MenuType.POINTS)),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
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
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
        child: const Text('Return'),
      ),
    );
  }
}
