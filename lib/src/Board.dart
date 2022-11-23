import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Task.dart';

class BoardState {
  String title;
  TaskState state;
  List<Task> tasks;

  BoardState(String title) {
    this.title = title;
  }
}

class Board {
  List<BoardState> states;

  Board() {
    states = List<BoardState>.empty(growable: true);
  }

  factory Board.fromMap(Map<String, dynamic> json) {
    Board boardS = Board();
    boardS.states = json['states'];
    return boardS;
  }
}
