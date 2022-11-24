import 'Task.dart';

class StateUtils {
  static TaskState ConvertStringToTaskState(String str) {
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

  static TaskPriority ConvertStringToTaskPriority(String str) {
    switch (str) {
      case "VERY LOW":
        return TaskPriority.VERY_LOW;
        break;
      case "LOW":
        return TaskPriority.LOW;
        break;
      case "MEDIUM":
        return TaskPriority.MEDIUM;
        break;
      case "HIGH":
        return TaskPriority.HIGH;
        break;
      default:
        return TaskPriority.VERY_HIGH;
    }
  }

  static TaskState ConvertIntToTaskState(int val) {
    switch (val) {
      case 1:
        return TaskState.TO_DO;
        break;
      case 2:
        return TaskState.IN_PROGRESS;
        break;
      case 3:
        return TaskState.REVIEW;
        break;
      default:
        return TaskState.DONE;
    }
  }

  static TaskPriority ConvertIntToTaskPriority(int val) {
    switch (val) {
      case 1:
        return TaskPriority.VERY_LOW;
        break;
      case 2:
        return TaskPriority.LOW;
        break;
      case 3:
        return TaskPriority.MEDIUM;
        break;
      case 3:
        return TaskPriority.HIGH;
        break;
      default:
        return TaskPriority.VERY_HIGH;
    }
  }
}
