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
      return tasks.docs.map((doc) => Task.fromDocumentSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
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

      return querySnapshot.docs.map((doc) => Task.fromDocumentSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
    } catch (e) {
      print('Error fetching tasks for date: $e');
      throw e;
    }
  }


 

  // Insert a new task
  Future<void> insertTask(Map<String, dynamic> task) async {
    try {
      await _tasksCollection.add(task);
    } catch (e) {
      print('Error inserting task: $e');
      throw e;
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

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
    } catch (e) {
      print('Error deleting task: $e');
      throw e;
    }
  }

  // Add a message to the task's messages collection
}
