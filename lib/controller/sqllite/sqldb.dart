import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todolist/model/todo_model.dart';

class SqlDBHelper {
  static late Database db;

  static initialDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todo.db');
    db = await openDatabase(
      path,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
          CREATE TABLE users (
          id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
          fullName nvarchar NOT NULL,
          email nvarchar NOT NULL,
          password nvarchar NOT NULL
        
          );''',
        );
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            toDoText TEXT NOT NULL,
            toDoDescription TEXT,
            category TEXT NOT NULL,
            isDone INTEGER NOT NULL
          );
          ''');
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertTask(ToDoModel task) async {
    await db.insert('tasks', task.tojson());
  }

  Future<void> updateTask(ToDoModel task) async {
    await db.update(
      'tasks',
      task.tojson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ToDoModel>> getAllTasks() async {
    try {
      final List<Map<String, dynamic>> maps = await db.query('tasks');
      if (maps.isEmpty) {
        return [];
      }
      return List.generate(maps.length, (i) {
        return ToDoModel.fromjson(maps[i]);
      });
    } catch (e) {
      log('Error fetching tasks: $e');
      return [];
    }
  }
}
