import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_management/models/task.dart';

class TaskDatabase {
  static final TaskDatabase _instance = TaskDatabase._internal();

  factory TaskDatabase() => _instance;

  TaskDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'tasks.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }

  static TaskDatabase get instance => TaskDatabase();

  Future<void> insertTask(Map<String, dynamic> task) async {
    final db = await database;
    final store = intMapStoreFactory.store('tasks');
    await store.add(db, task);
  }

 Future<List<Task>> fetchTasks() async {
  final db = await database;
  final store = intMapStoreFactory.store('tasks');
  final records = await store.find(db);
  return records.map((record) => Task.fromMap(record.value)).toList();
}

  Future<void> updateTask(Map<String, dynamic> task) async {
    final db = await database;
    final store = intMapStoreFactory.store('tasks');
    await store.record(task['id']).put(db, task);
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    final store = intMapStoreFactory.store('tasks');
    await store.record(id).delete(db);
  }
}
