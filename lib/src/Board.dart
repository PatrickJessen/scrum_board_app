import 'dart:ffi';

import 'package:flutter/material.dart';

import 'Task.dart';

class BoardState {
  String? title;
  TaskState? state;
  List<Task>? tasks;

  BoardState(String title) {
    this.title = title;
  }
}

class Board {
  late List<BoardState> states;

  Board() {
    states = List<BoardState>.empty(growable: true);
  }
}
