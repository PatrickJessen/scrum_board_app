import 'User.dart';

enum TaskState
{
  TO_DO,
  IN_PROGRESS,
  REVIEW,
  DONE
}

enum TaskPriority
{
  VERY_LOW,
  LOW,
  MEDIUM,
  HIGH,
  VERY_HIGH
}

class Task
{
  int? id;
  String? title;
  String? description;
  int? points;
  User? assignedTo;
  TaskState? state;
  TaskPriority? priority;

  Task(String title, int id)
  {
    this.title = title;
    this.id = id;
  }
}