import 'package:scrum_board_app/src/api/ApiAccess.dart';

import '../Task.dart';

class TaskManager {
  ApiAccess access = ApiAccess();
  void AddTask(Task task) {
    access.PostTask(task);
  }
}
