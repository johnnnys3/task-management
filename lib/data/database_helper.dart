import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class DatabaseHelper {
  static final _databaseName = "TMSS_Tasks.db";
  static final _databaseVersion = 1;

  static final _table = 'tasks';

  // Singleton pattern: Create a single instance of the DatabaseHelper class
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  // Getter for the instance
  static DatabaseHelper get instance => _instance;


  // Updated: Moved _db initialization inside an asynchronous function
  static Future<Database> get _db async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_table(id INTEGER PRIMARY KEY, name TEXT, completed INTEGER)',
        );
      },
      version: _databaseVersion,
    );
  }

  Future<void> insertTask(Task task) async {
    final db = await _db;
    await db.insert(
      _table,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> fetchTasks() async {
  final db = await _db;
  final List<Map<String, dynamic>> maps = await db.query(_table);
  return List.generate(maps.length, (i) {
    return Task(
      id: maps[i]['id'],
      title: maps[i]['title'],
      isCompleted: maps[i]['completed'] == 1,
      description: '', 
      dueDate: DateTime.now(), // You need to provide a default value for DateTime
      priority: 0, // You need to provide a default value for int
      attachments: [], 
      assignedTo: '',
    );
  });
}


  Future<void> updateTask(Task task) async {
    final db = await _db;
    await db.update(
      _table,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await _db;
    await db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
