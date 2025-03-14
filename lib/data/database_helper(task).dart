import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/models/task.dart';

class TaskDatabase {
  static final TaskDatabase _instance = TaskDatabase._internal();

  factory TaskDatabase() => _instance;

  TaskDatabase._internal();

  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');

  // Fetch all tasks
  Future<List<Task>> fetchTasks() async {
    try {
      final tasks = await _tasksCollection.get();
      return tasks.docs.map((doc) => Task.fromDocumentSnapshot(doc)).toList();
    } catch (e) {
      print('Error fetching tasks: $e');
      throw e;
    }
  }

  // Fetch tasks for a specific date
  Future<List<Task>> fetchTasksForDate(DateTime selectedDate) async {
    try {
      QuerySnapshot<Object?> querySnapshot = await _tasksCollection
          .where('dueDate', isGreaterThanOrEqualTo: selectedDate)
          .where('dueDate', isLessThan: selectedDate.add(Duration(days: 1)))
          .get();

      return querySnapshot.docs.map((doc) => Task.fromDocumentSnapshot(doc)).toList();
    } catch (e) {
      print('Error fetching tasks for date: $e');
      throw e;
    }
  }

  // Fetch tasks for a specific due date
  Future<List<Task>> fetchTasksForDueDate(DateTime dueDate) async {
    try {
      QuerySnapshot tasksSnapshot = await _tasksCollection.where('dueDate', isEqualTo: dueDate.toIso8601String()).get();
      List<Task> tasks = [];

      for (QueryDocumentSnapshot<Object?> doc in tasksSnapshot.docs) {
        Task task = Task.fromDocumentSnapshot(doc);
        tasks.add(task);
      }

      return tasks;
    } catch (error) {
      print('Error fetching tasks for due date: $error');
      throw Exception('Failed to fetch tasks for due date');
    }
  }



  // Update an existing task
  Future<void> updateTask(String taskId, Map<String, dynamic> task) async {
    try {
      await _tasksCollection.doc(taskId).update(task);
    } catch (e) {
      print('Error updating task: $e');
      throw e;
    }
  }

  static Future<List<Task>> getTasks() async {
  try {
    final taskDatabase = TaskDatabase(); // Create an instance
    final tasks = await taskDatabase._tasksCollection.get(); // Use the instance to access _tasksCollection
    return tasks.docs.map((doc) => Task.fromDocumentSnapshot(doc)).toList();
  } catch (e) {
    print('Error fetching tasks: $e');
    throw e;
  }
}

Future<List<Task>> fetchTasksForProject(String projectId) async {
    try {
      QuerySnapshot<Object?> querySnapshot = await _tasksCollection.where('projectId', isEqualTo: projectId).get();

      return querySnapshot.docs.map((doc) => Task.fromDocumentSnapshot(doc)).toList();
    } catch (e) {
      print('Error fetching tasks for project: $e');
      throw e;
    }
  }

}