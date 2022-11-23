import 'Board.dart';
import 'Task.dart';
import 'Data/TaskData.dart';
import 'api/BoardApi.dart';

class BoardController {
  Board board;
  TaskData data;
  BoardApi api = BoardApi();
  BoardController() {
    board = Board();
    data = TaskData();
    /*AddNewBoardState(TaskState.TO_DO, "TO DO");
    AddNewBoardState(TaskState.IN_PROGRESS, "IN PROGRESS");
    AddNewBoardState(TaskState.REVIEW, "REVIEW");
    AddNewBoardState(TaskState.DONE, "DONE");
    AddNewTaskToBoard(Task("Todo Task", TaskState.TO_DO));
    AddNewTaskToBoard(Task("Todo Task2", TaskState.TO_DO));
    AddNewTaskToBoard(Task("In Progress Task", TaskState.IN_PROGRESS));
    AddNewTaskToBoard(Task("Done Task", TaskState.DONE));
    AddNewTaskToBoard(Task("Done Task2", TaskState.DONE));*/
  }

  /*void ChangeTask(Task task, TaskState state) {
    for (int i = 0; i < board.states.length; i++) {
      for (int j = 0; j < board.states[i].tasks.length; j++) {
        if (board.states[i].tasks[j].id == task.id) {
          board.states[i].tasks[j].state = state;
          data.UpdateTask(task);
          return;
        }
      }
    }
  }

  void AddNewBoardState(TaskState state, String title) {
    BoardState bs = BoardState(title);
    bs.state = state;
    bs.tasks = List<Task>.empty(growable: true);
    board.states.add(bs);
    data.CreateBoardState(bs);
  }

  void AddNewTaskToBoard(Task task) {
    for (int i = 0; i < board.states.length; i++) {
      if (board.states[i].state == task.state) {
        board.states[i].tasks.add(task);
        data.CreateTask(task);
        return;
      }
    }
  }*/
}
