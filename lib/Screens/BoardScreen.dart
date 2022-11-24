// ignore_for_file: prefer_const_constructors
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:scrum_board_app/src/Managers/BoardManager.dart';
import 'package:scrum_board_app/src/Task.dart';
import 'package:scrum_board_app/src/api/ApiAccess.dart';
import '../src/Board.dart';
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
  Board board = Board();
  BoardManager manager = BoardManager();
  Future<List<BoardState>> boardStates;
  final BoardViewController boardViewController = BoardViewController();

  @override
  void initState() {
    super.initState();
    setState(() {    
      boardStates = manager.FetchBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BoardList> lists = List<BoardList>.empty(growable: true);
    return Scaffold(
      body: Stack(
        children: [
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
          Padding(
              padding: const EdgeInsets.all(50.0),
              child: FutureBuilder(
                  future: boardStates,
                  // ignore: missing_return
                  builder: (f, snapshot) {
                    if (snapshot.hasData) {
                      for (var i in snapshot.data) {
                        lists.add(_createBoardList(i, snapshot));
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

  BoardItem buildBoardItem(Task itemObject, AsyncSnapshot<dynamic> snapshot) {
    return BoardItem(
        onStartDragItem:
            (int listIndex, int itemIndex, BoardItemState state) {},
        onDropItem: (int listIndex, int itemIndex, int oldListIndex,
            int oldItemIndex, BoardItemState state) {
          //Used to update our local item data
          var item = snapshot.data[oldListIndex].tasks[oldItemIndex] as Task;
          snapshot.data[oldListIndex].tasks.removeAt(oldItemIndex);
          // can get the title from here to set the enum state
          //item.state = ConvertStringToTaskState(board.board.states[listIndex].title);
          snapshot.data[listIndex].tasks.insert(itemIndex, item);
        },
        onTapItem:
            (int listIndex, int itemIndex, BoardItemState state) async {
              Task t = snapshot.data[listIndex].tasks[itemIndex] as Task;
              Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TaskScreenWidget(), settings: RouteSettings(arguments: t)));
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

  Widget _createBoardList(BoardState state, AsyncSnapshot<dynamic> snapshot) {
    List<BoardItem> items = List<BoardItem>.empty(growable: true);
    for (int i = 0; i < state.tasks.length; i++) {
      items.insert(i, buildBoardItem(state.tasks[i], snapshot));
    }

    return BoardList(
      onStartDragList: (dynamic listIndex) {},
      onTapList: (dynamic listIndex) async {},
      onDropList: (dynamic listIndex, dynamic oldListIndex) {
        //Update our local list data
        /*var list = board.states[oldListIndex];
        board.states.removeAt(oldListIndex);
        board.states.insert(listIndex, list);*/
      },
      headerBackgroundColor: Colors.transparent,
      backgroundColor: Color(0xffECEDFC),
      header: [
        Expanded(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  state.title,
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
