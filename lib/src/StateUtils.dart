import 'Task.dart';

class StateUtils {
  static String ConvertTaskStateToString(TaskState state) {
    switch (state) {
      case TaskState.TO_DO:
        return "TODO";
      case TaskState.IN_PROGRESS:
        return "IN PROGRESS";
      case TaskState.REVIEW:
        return "REVIEW";
      default:
        return "DONE";
    }
  }

  static String ConvertTaskPriorityToString(TaskPriority state) {
    switch (state) {
      case TaskPriority.VERY_LOW:
        return "VERY LOW";
      case TaskPriority.LOW:
        return "LOW";
      case TaskPriority.MEDIUM:
        return "MEDIUM";
      case TaskPriority.HIGH:
        return "HIGH";
      default:
        return "VERY HIGH";
    }
  }

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
      case 0:
        return TaskState.TO_DO;
        break;
      case 1:
        return TaskState.IN_PROGRESS;
        break;
      case 2:
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
