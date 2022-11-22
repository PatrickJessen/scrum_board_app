import 'package:flutter/material.dart';
import '../src/Task.dart';

class NewTaskWidget extends StatefulWidget {
  const NewTaskWidget({super.key});

  @override
  State<NewTaskWidget> createState() => NewTaskScreen();
}

class NewTaskScreen extends State<NewTaskWidget> {
  Task? task;
  String statesVal = "TODO";
  List<String> states = ["TODO", "IN PROGRESS", "REVIEW", "DONE"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        DropdownButton(
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
          onChanged: (String? newValue) {
            setState(() {
              statesVal = newValue!;
            });
          },
        ),
      ],
    ));
  }
}
