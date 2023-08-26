import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void toggleTodoCompletion(int index) {
    _todos[index].isCompleted = !_todos[index].isCompleted;
    notifyListeners();
  }
}
