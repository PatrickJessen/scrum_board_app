import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  final String text;
  const EditText({Key key, this.text}) : super(key: key);

  @override
  State<EditText> createState() => _EditTextState(text);
}

class _EditTextState extends State<EditText> {
  String text;
  bool isEditing = false;
  TextEditingController controller;
  
  _EditTextState(this.text);


  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: text);
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
              text = newValue;
              isEditing = false;
            });
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
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
}