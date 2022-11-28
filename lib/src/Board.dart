import 'dart:convert';

import 'package:http/http.dart';

import 'StateUtils.dart';
import 'Task.dart';

class BoardState {
  String title;
  TaskState state;
  List<Task> tasks;

  BoardState(String title, TaskState state, List<Task> tasks) {
    this.title = title;
    this.state = state;
    this.tasks = tasks;
  }

  factory BoardState.fromJson(Map<String, dynamic> jsonObj) {
    List<dynamic> parsedListJson = jsonObj['tasks'];
    List<Task> test2 =
        (parsedListJson).map((data) => Task.fromJson(data)).toList();
    if (parsedListJson.isEmpty) {
      return BoardState(
          jsonObj['title'],
          StateUtils.ConvertIntToTaskState(jsonObj['state']),
          List<Task>.empty(growable: true));
    }
    return BoardState(
        jsonObj['title'],
        StateUtils.ConvertIntToTaskState(jsonObj['state']),
        (parsedListJson).map((data) => Task.fromJson(data)).toList());
  }
}

class Board {
  String title;
  List<Task> tasks;
  List<BoardState> states;

  Board(String title, List<Task> tasks) {
    states = List<BoardState>.empty(growable: true);
    this.title = title;
    this.tasks = tasks;
  }

  factory Board.fromJson(Map<String, dynamic> jsonObj) {
    List<dynamic> parsedListJson = jsonObj['tasks'];
    List<Task> test2 =
        (parsedListJson).map((data) => Task.fromJson(data)).toList();
    if (parsedListJson.isEmpty) {
      return Board(jsonObj['title'], List<Task>.empty(growable: true));
    }
    return Board(jsonObj['title'],
        (parsedListJson).map((data) => Task.fromJson(data)).toList());
  }
}
