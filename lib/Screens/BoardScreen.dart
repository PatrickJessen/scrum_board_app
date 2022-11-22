// ignore_for_file: prefer_const_constructors
import 'package:boardview/boardview.dart';
import 'package:flutter/material.dart';
import 'package:scrum_board_app/src/Task.dart';
import '../src/BoardController.dart';
import 'NewTaskScreen.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  final String page1 = "Scrumboard";
  final String page2 = "NewTask";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyWidget(),
    );
  }
}

class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState() => BoardScreen();
}

class BoardScreen extends State<BoardWidget> {
  BoardController board = BoardController();

  late List<Widget> pages;
  late Widget page1;
  late Widget page2;
  late int currentIndex;
  late Widget currentPage;

  @override
  void initState() {
    super.initState();
    page1 = const BoardWidget();
    page2 = const NewTaskWidget();
    pages = [page1, page2];
    currentIndex = 0;
    currentPage = page1;
  }

  void ChangeTab(int index) {
    setState(() {
      currentIndex = index;
      currentPage = pages[index];
    });
  }

  void test() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.all(60),
          color: Color.fromARGB(255, 165, 165, 165),
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              for (var i in board.board!.states)
                Container(
                  color: Color.fromARGB(255, 89, 89, 90),
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        i.title.toString(),
                        style: TextStyle(fontSize: 25),
                      ),
                      for (var n in i.tasks!)
                        Container(
                          width: 340,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 206, 206, 206),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
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
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          left: 60,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NewTaskWidget()));
            },
            child: Text('Add Task'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
            ),
          ),
        ),
      ]),
    );
  }
}


            /*ElevatedButton(
              onPressed: () {},
              child: Text('Add Task'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),*/