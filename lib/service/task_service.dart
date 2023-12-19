import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/models/task.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Task>> getTasks({required String userId}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('tasks').where('userId', isEqualTo: userId).get();

      List<Task> tasks = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Task.fromMap(data);
      }).toList();

      return tasks;
    } catch (e) {
      // Handle errors
      print('Error fetching tasks: $e');
      throw e;
    }
  }

  Future<void> addTask({required String userId, required Task task}) async {
    try {
      await _firestore.collection('tasks').add({
        'userId': userId,
        'title': task.title,
        'description': task.description,
        'dueDate': task.dueDate,
        // Add more fields as needed
      });
    } catch (e) {
      // Handle errors
      print('Error adding task: $e');
      throw e;
    }
  }

Future<void> updateTask({required String taskId, required Task task}) async {
  try {
    await _firestore.collection('tasks').doc(taskId).update({
      'title': task.title,
      'description': task.description,
      'dueDate': task.dueDate,
      // Update more fields as needed
    });
  } catch (e) {
    // Handle errors
    print('Error updating task: $e');
    throw e;
  }
}

  Future<void> deleteTask({required String taskId, required String userId}) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      // Handle errors
      print('Error deleting task: $e');
      throw e;
    }
  }
}
