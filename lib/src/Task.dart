import 'User.dart';

enum TaskState { TO_DO, IN_PROGRESS, REVIEW, DONE }

enum TaskPriority { VERY_LOW, LOW, MEDIUM, HIGH, VERY_HIGH }

class Task {
  int id;
  String title;
  String description;
  int points;
  String assignedTo;
  TaskState state;
  TaskPriority priority;

  Task(String title, String description, int points, String assignedTo, TaskState state, TaskPriority priority) {
    this.title = title;
    this.description = description;
    this.points = points;
    this.assignedTo = assignedTo;
    this.state = state;
    this.priority = priority;
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(json['title'], json['description'], json['points'], json['assignedTo'], ConvertIntToTaskState(json['state']), ConvertIntToTaskPriority(json['priority']));
  }

  static TaskState ConvertIntToTaskState(int val){
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

  static TaskPriority ConvertIntToTaskPriority(int val){
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
