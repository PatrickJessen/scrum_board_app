// ignore_for_file: prefer_const_constructors
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:scrum_board_app/src/Task.dart';
import '../src/Board.dart';
import '../src/BoardController.dart';

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
  BoardController board = BoardController();

  final BoardViewController boardViewController = BoardViewController();

  @override
  Widget build(BuildContext context) {
    List<BoardList> lists = List<BoardList>.empty(growable: true);
    
    for (int i = 0; i < board.board.states.length; i++) {
      lists.add(_createBoardList(board.board.states[i]));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BoardView(
        lists: lists,
        boardViewController: boardViewController,
      ),
    );
  }

  BoardItem buildBoardItem(Task itemObject) {
    TaskState ConvertStringToTaskState(String str)
    {
      switch (str) {
        case "TODO":
          return TaskState.TO_DO;
          break;
        case "IN PROGRESS":
          return TaskState.IN_PROGRESS;
          break;
        case "REVIEW":
          return TaskState.REVIEW;
          break;
        case "DONE":
          return TaskState.DONE;
          break;
        default:
          return TaskState.TO_DO;
      }
    }
    return BoardItem(
        onStartDragItem: (int listIndex, int itemIndex, BoardItemState state) {

        },
        onDropItem: (int listIndex, int itemIndex, int oldListIndex,
          int oldItemIndex, BoardItemState state) {
          
          //Used to update our local item data
          var item = board.board.states[oldListIndex].tasks[oldItemIndex];
          board.board.states[oldListIndex].tasks.removeAt(oldItemIndex);
          // can get the title from here to set the enum state
          item.state = ConvertStringToTaskState(board.board.states[listIndex].title);
          print(item.state);
          board.board.states[listIndex].tasks.insert(itemIndex, item);
        },
        onTapItem: (int listIndex, int itemIndex, BoardItemState state) async {
        },
        item: Container(
          margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(itemObject.title.toString(), style: TextStyle(
                    height: 1.5,
                    color: Color(0xff2F334B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 10.0,),
                  Text(itemObject.description.toString(), style: TextStyle(
                    height: 1.5,
                    color: Color(0xff2F334B),
                    fontSize: 16
                  ),),
                ],
              )
            ),
          ),
        ));
  }

  Widget _createBoardList(BoardState state) {
    List<BoardItem> items = List<BoardItem>.empty(growable: true);
      for (int i = 0; i < state.tasks.length; i++){
        items.insert(i, buildBoardItem(state.tasks[i]));
      }


    return BoardList(
      onStartDragList: (dynamic listIndex) {

      },
      onTapList: (dynamic listIndex) async {

      },
      onDropList: (dynamic listIndex, dynamic oldListIndex) {
        //Update our local list data
        var list = board.board.states[oldListIndex];
        board.board.states.removeAt(oldListIndex);
        board.board.states.insert(listIndex, list);
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
                color: Color(0xff2F334B)
              ),
            )
          )
        ),
      ],
      items: items,
    );
  }
}
