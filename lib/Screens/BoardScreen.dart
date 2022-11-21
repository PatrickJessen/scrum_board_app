// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../src/Board.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => BoardScreen();
}

class BoardScreen extends State<MyWidget> {
  Board board = Board();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 54, 244, 101),
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (var i in board.states)
              Container(
                color: Colors.blue,
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (var n in i.tasks!)
                      Container(
                        width: 340,
                        height: 50,
                        color: Color.fromARGB(255, 243, 33, 33),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            n.title.toString(),
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
