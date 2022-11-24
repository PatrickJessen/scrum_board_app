import 'package:flutter/material.dart';

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
                left: 160,
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
                        child: EditText(text: task.title),
                      ),
                    ),
                  ],
                )),
            Positioned(
                left: 460,
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
                        child: EditText(text: task.description),
                      ),
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
