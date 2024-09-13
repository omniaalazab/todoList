import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todolist/controller/sqllite/sqldb.dart';
import 'package:todolist/model/todo_model.dart';

class TaskCubit extends Cubit<List<ToDoModel>> {
  TaskCubit() : super([]);
  List<ToDoModel> allTasks = [];
  Future<void> loadTasks() async {
    final tasks = await SqlDBHelper().getAllTasks();
    allTasks = tasks;
    emit(tasks);
  }

  Future<void> addTask(ToDoModel task) async {
    await SqlDBHelper().insertTask(task);
    log("task was added");
    await loadTasks();
  }

  Future<void> changeTaskDone(ToDoModel task) async {
    task.isDone = !task.isDone!;
    await SqlDBHelper().updateTask(task);
    log("task was changed");
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await SqlDBHelper().deleteTask(id);
    log("task was deleted");
    await loadTasks();
  }

  void searchTasks(String query, bool? isDoneFilter) {
    List<ToDoModel> filteredTasks = allTasks;

    if (query.isNotEmpty) {
      filteredTasks = filteredTasks
          .where((task) =>
              task.toDoText!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    if (isDoneFilter != null) {
      filteredTasks =
          filteredTasks.where((task) => task.isDone == isDoneFilter).toList();
    }

    emit(filteredTasks);
  }
}
