import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/models/project.dart';

class ProjectDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'projects'; // Change this to your Firestore collection name

  Future<void> addProject(Project project) async {
    try {
      await _firestore.collection(_collectionName).add(project.toMap());
    } catch (e) {
      print('Error adding project: $e');
      throw e;
    }
  }

  Future<void> updateProject(Project project) async {
    try {
      await _firestore.collection(_collectionName).doc(project.id).update(project.toMap());
    } catch (e) {
      print('Error updating project: $e');
      throw e;
    }
  }

  Future<void> deleteProject(String projectId) async {
    try {
      await _firestore.collection(_collectionName).doc(projectId).delete();
    } catch (e) {
      print('Error deleting project: $e');
      throw e;
    }
  }

  Stream<List<Project>> getProjectsStream() {
    return _firestore.collection(_collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Project.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  Future<Project?> getProjectById(String projectId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.collection(_collectionName).doc(projectId).get();
      if (snapshot.exists) {
        return Project.fromDocumentSnapshot(snapshot);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting project: $e');
      throw e;
    }
  }
}
