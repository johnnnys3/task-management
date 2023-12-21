import 'package:flutter/material.dart';
import 'package:task_management/models/project.dart';
import 'package:task_management/models/task.dart';
import 'dart:async';

import 'package:task_management/data/database_helper(task).dart';

class TaskProvider extends ChangeNotifier {
  late Task _task;

  Task get task => _task;

  void updateTask({
    required String name,
    required String description,
    required DateTime dueDate,
    required List<String> attachments,
    required bool isCompleted,
    required Project? associatedProject,
    required List<String> assignedMembers,
  }) {
    _task = Task(
      id: '',
      title: name,
      description: description,
      dueDate: dueDate,
      attachments: attachments,
      isCompleted: isCompleted,
      associatedProject: associatedProject,
      assignedMembers: assignedMembers,
    );
    notifyListeners();
  }
}

class TaskListProvider extends ChangeNotifier {
  final TaskDatabase _taskDatabase = TaskDatabase();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    try {
      _tasks = await _taskDatabase.fetchTasks();
      notifyListeners();
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }
}
