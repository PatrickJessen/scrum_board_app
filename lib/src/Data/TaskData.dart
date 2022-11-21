import 'dart:ffi';

import '../Task.dart';

class TaskData
{
  void CreateTask(Task task)
  {

  }

  Task UpdateTask(Task task)
  {
    return Task("", 1);
  }

  Task GetTask(Task task)
  {
    return task;
  }

  void DeleteTask(int id)
  {

  }

  int GetLatestTaskID()
  {
    return 0;
  }
}