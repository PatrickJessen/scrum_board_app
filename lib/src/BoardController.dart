import 'Board.dart';
import 'Task.dart';
import 'Data/TaskData.dart';

class BoardController
{
  Board? board;
  TaskData? data;
  BoardController(Board board)
  {
    this.board = board;
    data = TaskData();
  }

  void ChangeTask(Task task, TaskState state)
  {
    for (int i = 0; i < board!.states.length; i++) {
      for (int j = 0; j < board!.states[i].tasks!.length; j++) {
        if (board!.states[i].tasks![j].id == task.id) {
          board!.states[i].tasks![j].state = state;
        }
      }
    }
  }
}