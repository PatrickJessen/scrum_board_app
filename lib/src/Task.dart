import 'StateUtils.dart';
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
  String boardTitle;

  Task(String title, String description, int points, String assignedTo,
      TaskState state, TaskPriority priority) {
    this.title = title;
    this.description = description;
    this.points = points;
    this.assignedTo = assignedTo;
    this.state = state;
    this.priority = priority;
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    Task task = Task(
        json['title'],
        json['description'],
        json['points'],
        json['assignedTo'],
        StateUtils.ConvertIntToTaskState(json['state']),
        StateUtils.ConvertIntToTaskPriority(json['priority']));
    task.id = json['id'] as int;
    return task;
  }
}
