import 'package:scrum_board_app/src/api/ApiAccess.dart';

import '../Task.dart';

/**
 * Manager class for Task
 * used to implement any logic (if needed)
 */
class TaskManager {
  ApiAccess access = ApiAccess();
  void AddTask(Task task) {
    access.PostTask(task);
  }

  void UpdateTask(Task task) {
    access.UpdateTask(task);
  }

  void DeleteTask(int id) {
    access.DeleteTask(id);
  }
}
