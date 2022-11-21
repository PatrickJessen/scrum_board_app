import 'dart:ffi';

import 'Task.dart';

class BoardState
{
  TaskState? state;
  List<Task>? tasks;
}

class Board
{
  late List<BoardState> states;

  Board()
  {
    states = List<BoardState>.empty(growable: true);
    AddNewBoardState(TaskState.TO_DO);
    AddNewBoardState(TaskState.IN_PROGRESS);
    AddNewBoardState(TaskState.REVIEW);
  }

  void AddNewBoardState(TaskState state)
  {
    BoardState bs = BoardState();
    bs.state = state;
    bs.tasks = List<Task>.empty(growable: true);
    bs.tasks?.add(Task("title", 1));
    bs.tasks?.add(Task("title2", 2));

    states.add(bs);
  }
}