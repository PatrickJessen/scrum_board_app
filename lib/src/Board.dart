import 'dart:convert';

import 'package:http/http.dart';

import 'StateUtils.dart';
import 'Task.dart';

/**
 * This class represents each board state like TODO, In Progress etc..
 * wich stores tasks with the same state
 */
class BoardState {
  String title;
  TaskState state;
  List<Task> tasks;

  BoardState(String title, TaskState state) {
    this.title = title;
    this.state = state;
    tasks = List<Task>.empty(growable: true);
  }
}

/**
 * This class represents the whole sprint board
 * It takes all the tasks wich will later be sorted
 * into its own BoardState
 */
class Board {
  int id;
  String title;
  List<Task> tasks;

  Board(int id, String title, List<Task> tasks) {
    this.id = id;
    this.title = title;
    this.tasks = tasks;
  }

  factory Board.fromJson(Map<String, dynamic> jsonObj) {
    List<dynamic> parsedListJson = jsonObj['tasks'];
    List<Task> test2 =
        (parsedListJson).map((data) => Task.fromJson(data)).toList();

    if (parsedListJson.isEmpty) {
      return Board(
          jsonObj['id'], jsonObj['title'], List<Task>.empty(growable: true));
    }
    return Board(jsonObj['id'], jsonObj['title'],
        (parsedListJson).map((data) => Task.fromJson(data)).toList());
  }
}
