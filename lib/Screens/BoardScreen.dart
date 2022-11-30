// ignore_for_file: prefer_const_constructors
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:scrum_board_app/Screens/LoginScreen.dart';
import 'package:scrum_board_app/src/Managers/BoardManager.dart';
import 'package:scrum_board_app/src/Task.dart';
import 'package:scrum_board_app/src/api/ApiAccess.dart';
import 'package:scrum_board_app/src/api/FirebaseAccess.dart';
import '../src/Board.dart';
import '../src/Managers/TaskManager.dart';
import '../src/StateUtils.dart';
import '../src/User.dart';
import 'DropDownMenu.dart';
import 'NewTaskScreen.dart';
import 'TaskScreen.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key key}) : super(key: key);

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
  const BoardWidget({Key key}) : super(key: key);

  @override
  State<BoardWidget> createState() => BoardScreen();
}

class BoardScreen extends State<BoardWidget> {
  Future<Board> futureBoard;
  BoardManager manager = BoardManager();
  final BoardViewController boardViewController = BoardViewController();
  TaskManager taskManager;

  List<String> states = ["TODO", "IN PROGRESS", "REVIEW", "DONE"];
  List<BoardState> boardStates;
  Future<List<String>> futureSprintNames;
  List<String> sprintNames;
  String currentSprint;
  TextEditingController editSprintText;
  FirebaseAccess firebase;

  void InitFirebase() async {
      firebase = FirebaseAccess();
      await firebase.RequestPermission(User.currentUser.username);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      taskManager = TaskManager();
      editSprintText = TextEditingController();
      InitFirebase();
      manager.FetchSprintNames().then((value) {
        setState(() {
          sprintNames = value;
          currentSprint = sprintNames[0];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //SprintNames(),
          Container(
            alignment: Alignment.topRight,
            child: DropdownButton(
              // Initial Value
              value: currentSprint,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: sprintNames.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String newValue) {
                setState(() {
                  String sprint = newValue;
                  currentSprint = sprint;
                });
              },
            ),
          ),
          Positioned(
            top: 20,
            left: 300,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text('Add new sprint'),
                          content: Form(
                              child: Column(children: [
                            Text('Sprint name'),
                            TextFormField(
                              controller: editSprintText,
                              decoration: InputDecoration(
                                hintText: 'Name of sprint',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                manager.CreateSprint(editSprintText.text);
                                editSprintText.text = "";
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                            ),
                          ])));
                    });
              },
              child: Text('New Sprint'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 180,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewTaskWidget(),
                    settings: RouteSettings(arguments: currentSprint)));
              },
              child: Text('Add Task'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 300,
            child: ElevatedButton(
              onPressed: () async {
                String token = await firebase.GetUserToken(User.currentUser.username);
                await firebase.SendPushNotification(token, "hello world", "new notification");
              },
              child: Text('push'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 60,
            child: ElevatedButton(
              onPressed: () {
                User.currentUser = null;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(50.0),
              child: FutureBuilder(
                  future: manager.FetchBoard(currentSprint),
                  // ignore: missing_return
                  builder: (f, snapshot) {
                    if (snapshot.hasData) {
                      List<BoardList> lists =
                          List<BoardList>.empty(growable: true);

                      boardStates = List<BoardState>.empty(growable: true);
                      boardStates.add(BoardState("TODO", TaskState.TO_DO));
                      boardStates.add(
                          BoardState("IN PROGRESS", TaskState.IN_PROGRESS));
                      boardStates.add(BoardState("REVIEW", TaskState.REVIEW));
                      boardStates.add(BoardState("DONE", TaskState.DONE));
                      for (var n in snapshot.data.tasks) {
                        for (var i in boardStates) {
                          if (i.state == n.state) {
                            i.tasks.add(n);
                          }
                        }
                      }

                      for (var i in boardStates) {
                        lists.add(_createBoardList(i.title, i));
                      }
                      return BoardView(
                        lists: lists,
                        boardViewController: boardViewController,
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
        ],
      ),
    );
  }

  BoardItem buildBoardItem(Task itemObject, boardState) {
    return BoardItem(
        onStartDragItem:
            (int listIndex, int itemIndex, BoardItemState state) {},
        onDropItem: (int listIndex, int itemIndex, int oldListIndex,
            int oldItemIndex, BoardItemState state) {
          //Used to update our local item data
          var item = boardState.tasks[oldItemIndex] as Task;
          boardState.tasks.removeAt(oldItemIndex);
          // can get the title from here to set the enum state
          item.state = StateUtils.ConvertStringToTaskState(
              StateUtils.ConvertTaskStateToString(
                  StateUtils.ConvertIntToTaskState(listIndex)));
          boardState.tasks.insert(itemIndex, item);
          taskManager.UpdateTask(item);
        },
        onTapItem: (int listIndex, int itemIndex, BoardItemState state) async {
          Task t = boardState.tasks[itemIndex];
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TaskScreenWidget(),
              settings: RouteSettings(arguments: t)));
        },
        item: Container(
          margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Card(
            elevation: 0,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      itemObject.title.toString(),
                      style: TextStyle(
                          height: 1.5,
                          color: Color(0xff2F334B),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      itemObject.description.toString(),
                      style: TextStyle(
                          height: 1.5, color: Color(0xff2F334B), fontSize: 16),
                    ),
                  ],
                )),
          ),
        ));
  }

  Widget _createBoardList(String title, BoardState boardState) {
    List<BoardItem> items = List<BoardItem>.empty(growable: true);
    for (int i = 0; i < boardState.tasks.length; i++) {
      items.insert(i, buildBoardItem(boardState.tasks[i], boardState));
    }

    return BoardList(
      headerBackgroundColor: Colors.transparent,
      backgroundColor: Color(0xffECEDFC),
      header: [
        Expanded(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2F334B)),
                ))),
      ],
      items: items,
    );
  }
}
