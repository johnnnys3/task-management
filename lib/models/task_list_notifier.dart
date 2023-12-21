import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';

class TaskListNotifier extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }
}
