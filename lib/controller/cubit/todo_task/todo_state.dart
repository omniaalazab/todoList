import 'package:todolist/model/todo_model.dart';

class ToDoStatus {}

class ToDoInitial extends ToDoStatus {}

class ToDoLoading extends ToDoStatus {}

class ToDoSuccess extends ToDoStatus {
  final ToDoModel todo;

  ToDoSuccess(this.todo);
}

class ToDoFailure extends ToDoStatus {
  final String error;

  ToDoFailure(this.error);
}
